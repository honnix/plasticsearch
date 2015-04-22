:- module(plasticsearch, [
    '.'/3,              % +Ps, +Term, -Result
    plasticsearch/1,    % -Ps
    plasticsearch/2,    % -Ps, +Options
    plasticsearch/3,    % -Ps, +Hosts, +Options
    destroy/1,          % +Ps
    ping/1,             % +Ps
    ping/2,             % +Ps, +Params
    info/2,             % +Ps, -Reply
    info/3,             % +Ps, +Params, -Reply
    create/6,           % +Ps, +Index, +DocType, +ID, +Body, -Reply
    create/7,           % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    index/6,            % +Ps, +Index, +DocType, +ID, +Body, -Reply
    index/7             % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
]).

/** <module> Elasticsearch Prolog APIs.
This is basically a Prolog version of
[Elasticsearch Python APIs](https://github.com/elastic/elasticsearch-py).

@auther Hongxin Liang
@license TBD
@see https://github.com/elastic/elasticsearch-py
@tbd Sniffing is not supported.
*/

:- use_module(library(uuid)).
:- use_module(library(uri)).

:- use_module(registry).

:- use_module(cluster, []).
:- use_module(nodes, []).
:- use_module(indices, []).
:- use_module(snapshots, []).

:- use_module(transport).
:- use_module(util).

%% '.'(+Ps, +Term, -Result) is semidet.
%
% Syntactic sugar for invoking APIs.

'.'(Ps, cluster, [cluster, Ps]) :- !.
'.'(Ps, nodes, [nodes, Ps]) :- !.
'.'(Ps, indices, [indices, Ps]) :- !.
'.'(Ps, snapshots, [snapshots, Ps]) :- !.

'.'([Module, Ps], Term, true) :- !,
    Term =.. [Name|Args],
    TermWithPs =.. [Name|[Ps|Args]],
    ModuledTerm =.. [:, Module, TermWithPs],
    call(ModuledTerm).

'.'(Ps, Term, true) :-
    Term =.. [Name|Args],
    TermWithPs =.. [Name|[Ps|Args]],
    call(TermWithPs).

%% plasticsearch(-Ps) is det.
%% plasticsearch(-Ps, +Options) is det.
%% plasticsearch(-Ps, +Hosts, +Options) is det.
%
% Create a new Plasticsearch instance.
%
% Default options are:
% ==
% dead_timeout(60)
% retry_on_timeout(false)
% max_retries(3)
% timeout_cutoff(5)
% random_selector(false)
% retry_on_status([503, 504])
% ==
%
% If no =Hosts= are given, http://localhost:9200 will be
% used by default. If only hostname is provided,
% port 9200 will be used and http will be assumed. Otherwise
% = uri_components(Scheme, Authority, Path, Search, Fragment) =
% can be used for fine-grained configuration.

plasticsearch(Ps) :-
    plasticsearch(Ps, []).

plasticsearch(Ps, Options) :-
    uuid(Ps),
    uri_components('http://localhost:9200', NormalizedHost),
    fill_options(Options, FullOptions),
    new(Ps, _{id:Ps, hosts:[NormalizedHost], options:FullOptions}).

plasticsearch(Ps, Hosts, Options) :-
    uuid(Ps),
    (   is_list(Hosts)
    ->  Hosts1 = Hosts
    ;   Hosts1 = [Hosts]
    ),
    normalize_hosts(Hosts1, NormalizedHosts),
    fill_options(Options, FullOptions),
    new(Ps, _{id:Ps, hosts:NormalizedHosts, options:FullOptions}).

normalize_hosts([], []) :- !.

normalize_hosts([H|T], NormalizedHosts) :-
    atom(H), !,
    normalize_hosts(T, NormalizedHosts0),
    (   sub_atom_icasechk(H, _, '://')
    ->  Host = H
    ;   atomic_list_concat(['http://', H, :, 9200], Host)
    ),
    uri_components(Host, NormalizedHost),
    NormalizedHosts = [NormalizedHost|NormalizedHosts0].

normalize_hosts([H|T], NormalizedHosts) :-
    compound_name_arity(H, uri_components, 5), !,
    normalize_hosts(T, NormalizedHosts0),
    NormalizedHosts = [H|NormalizedHosts0].

fill_options(Options, FullOptions) :-
    fill_options0([
            dead_timeout(60),
            retry_on_timeout(false),
            max_retries(3),
            timeout_cutoff(5),
            random_selector(false),
            retry_on_status([503, 504])
        ], Options, FullOptions).

fill_options0([], OldOptions, OldOptions) :- !.
fill_options0([H|T], OldOptions, NewOptions) :-
    fill_options0(T, OldOptions, NewOptions0),
    H =.. [Name, _],
    ToCheck =.. [Name, _],
    (   memberchk(ToCheck, NewOptions0)
    ->  NewOptions = NewOptions0
    ;   NewOptions = [H|NewOptions0]
    ).

%% destroy(+Ps) is det.
%
% Destory a Plasticsearch instance.

destroy(Ps) :-
    ignore(delete(Ps)).

%% ping(+Ps) is semidet.
%% ping(+Ps, +Params) is semidet.
%
% Returns True if the cluster is up, False otherwise.

ping(Ps) :-
    ping(Ps, _{}).

ping(Ps, Params) :-
    (   catch(perform_request(Ps, head, /, Params, _, _), E, true)
    ->  (   var(E)
        ->  true
        )
    ).

%% info(+Ps, -Reply) is semidet.
%% info(+Ps, +Params, -Reply) is semidet.
%
% Get the basic info from the current cluster.

info(Ps, Reply) :-
    info(Ps, _{}, Reply).

info(Ps, Params, Reply) :-
    perform_request(Ps, get, /, Params, _, Reply).

%% create(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% create(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% Adds a typed document in a specific index, making it searchable.
% Behind the scenes this predicate calls index/7 with = op_type=create = as
% additional parameter.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-index_.html).

create(Ps, Index, DocType, ID, Body, Reply) :-
    create(Ps, Index, DocType, ID, _{}, Body, Reply).

create(Ps, Index, DocType, ID, Params, Body, Reply) :-
    put_dict([op_type=create], Params, NewParams),
    index(Ps, Index, DocType, ID, NewParams, Body, Reply).

%% index(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% index(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% Adds or updates a typed document in a specific index, making it searchable.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-index_.html).

index(Ps, Index, DocType, ID, Body, Reply) :-
    index(Ps, Index, DocType, ID, _{}, Body), Reply.

index(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, Body-body]), non_empty(Value, Name)),
    (   non_empty(ID, _, false)
    ->  Method = put
    ;   Method = post
    ),
    make_context([Index, DocType, ID], Context),
    perform_request(Ps, Method, Context, Params, Body, _, Reply).