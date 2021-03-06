:- module(plasticsearch, [
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
    index/7,            % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    exists/4,           % +Ps, +Index, +DocType, +ID
    exists/5,           % +Ps, +Index, +DocType, +ID, +Params
    get/5,              % +Ps, +Index, +DocType, +ID, -Reply
    get/6,              % +Ps, +Index, +DocType, +ID, +Params, -Reply
    get_source/5,       % +Ps, +Index, +DocType, +ID, -Reply
    get_source/6,       % +Ps, +Index, +DocType, +ID, +Params, -Reply
    mget/5,             % +Ps, +Index, +DocType, -Reply
    mget/6,             % +Ps, +Index, +DocType, +Params, -Reply
    update/6,           % +Ps, +Index, +DocType, +ID, +Body, -Reply
    update/7,           % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    search/5,           % +Ps, +Index, +DocType, +Body, -Reply
    search/6,           % +Ps, +Index, +DocType, +Params, +Body, -Reply
    search_shards/4,    % +Ps, +Index, +DocType, -Reply
    search_shards/5,    % +Ps, +Index, +DocType, +Params, -Reply
    search_template/5,  % +Ps, +Index, +DocType, +Body, -Reply
    search_template/6,  % +Ps, +Index, +DocType, +Params, +Body, -Reply
    explain/6,          % +Ps, +Index, +DocType, +ID, +Body, -Reply
    explain/7,          % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    scroll/3,           % +Ps, ID, -Reply
    scroll/4,           % +Ps, ID, +Params, -Reply
    clear_scroll/4,     % +Ps, ID, +Body, -Reply
    clear_scroll/5,     % +Ps, ID, +Params, +Body, -Reply
    delete/5,           % +Ps, +Index, +DocType, +ID, -Reply
    delete/6,           % +Ps, +Index, +DocType, +ID, +Params, -Reply
    count/5,            % +Ps, +Index, +DocType, +Body, -Reply
    count/6,            % +Ps, +Index, +DocType, +Params, +Body, -Reply
    bulk/5,             % +Ps, +Index, +DocType, +Body, -Reply
    bulk/6,             % +Ps, +Index, +DocType, +Params, +Body, -Reply
    msearch/5,          % +Ps, +Index, +DocType, +Body, -Reply
    msearch/6,          % +Ps, +Index, +DocType, +Params, +Body, -Reply
    delete_by_query/5,  % +Ps, +Index, +DocType, +Body, -Reply
    delete_by_query/6,  % +Ps, +Index, +DocType, +Params, +Body, -Reply
    suggest/4,          % +Ps, +Index, +Body, -Reply
    suggest/5,          % +Ps, +Index, +Params, +Body, -Reply
    percolate/6,        % +Ps, +Index, +DocType, +ID, +Body, -Reply
    percolate/7,        % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    mpercolate/5,       % +Ps, +Index, +DocType, +Body, -Reply
    mpercolate/6,       % +Ps, +Index, +DocType, +Params, +Body, -Reply
    count_percolate/6,  % +Ps, +Index, +DocType, +ID, +Body, -Reply
    count_percolate/7,  % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    mlt/6,              % +Ps, +Index, +DocType, +ID, +Body, -Reply
    mlt/7,              % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    termvectors/6,      % +Ps, +Index, +DocType, +ID, +Body, -Reply
    termvectors/7,      % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    termvector/6,       % +Ps, +Index, +DocType, +ID, +Body, -Reply
    termvector/7,       % +Ps, +Index, +DocType, +ID, +Params, +Body, -Reply
    mtermvectors/5,     % +Ps, +Index, +DocType, +Body, -Reply
    mtermvectors/6,     % +Ps, +Index, +DocType, +Params, +Body, -Reply
    benchmark/5,        % +Ps, +Index, +DocType, +Body, -Reply
    benchmark/6,        % +Ps, +Index, +DocType, +Params, +Body, -Reply
    abort_benchmark/3,  % +Ps, +Name, -Reply
    abort_benchmark/4,  % +Ps, +Name, +Params, -Reply
    list_benchmark/4,   % +Ps, +Index, +DocType, -Reply
    list_benchmark/5,   % +Ps, +Index, +DocType, +Params, -Reply
    put_script/5,       % +Ps, +Lang, +ID, +Body, -Reply
    put_script/6,       % +Ps, +Lang, +ID, +Params, +Body, -Reply
    get_script/4,       % +Ps, +Lang, +ID, -Reply
    get_script/5,       % +Ps, +Lang, +ID, +Params, -Reply
    delete_script/4,    % +Ps, +Lang, +ID, -Reply
    delete_script/5,    % +Ps, +Lang, +ID, +Params, -Reply
    put_template/4,     % +Ps, +ID, +Body, -Reply
    put_template/5,     % +Ps, +ID, +Params, +Body, -Reply
    get_template/3,     % +Ps, +ID, -Reply
    get_template/4,     % +Ps, +ID, +Params, -Reply
    delete_template/3,  % +Ps, +ID, -Reply
    delete_template/4,  % +Ps, +ID, +Params, -Reply
    search_exists/5,    % +Ps, +Index, +DocType, +Body, -Reply
    search_exists/6     % +Ps, +Index, +DocType, +Params, +Body, -Reply
]).

/** <module> Elasticsearch Prolog APIs.
This is basically a Prolog version of
[Elasticsearch Python APIs](https://github.com/elastic/elasticsearch-py).

@author Hongxin Liang
@license Apache License Version 2.0
@see https://github.com/elastic/elasticsearch-py
@tbd Sniffing is not supported.
*/

:- use_module(library(uuid)).
:- use_module(library(uri)).
:- use_module(library(http/json)).

:- use_module(registry).

:- use_module(cluster, []).
:- use_module(nodes, []).
:- use_module(indices, []).
:- use_module(snapshots, []).

:- use_module(transport).
:- use_module(util).

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
    index(Ps, Index, DocType, ID, _{}, Body, Reply).

index(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, Body-body]), non_empty(Value, Name)),
    (   non_empty(ID, _, false)
    ->  Method = put
    ;   Method = post
    ),
    make_context([Index, DocType, ID], Context),
    perform_request(Ps, Method, Context, Params, Body, _, Reply).

%% exists(+Ps, +Index, +DocType, +ID) is semidet.
%% exists(+Ps, +Index, +DocType, +ID, +Params) is semidet.
%
% Returns a boolean indicating whether or not given document exists in Elasticsearch.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-get.html).

exists(Ps, Index, DocType, ID) :-
    exists(Ps, Index, DocType, ID, _{}).

exists(Ps, Index, DocType, ID, Params) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID], Context),
    (   catch(perform_request(Ps, head, Context, Params, _, _), E, true)
    ->  (   var(E)
        ->  true
        ;   E = plasticsearch_exception(404, _)
        )
    ).

%% get(+Ps, +Index, +DocType, +ID, -Reply) is semidet.
%% get(+Ps, +Index, +DocType, +ID, +Params, -Reply) is semidet.
%
% Get a typed document from the index based on its id.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-get_.html).

get(Ps, Index, DocType, ID, Reply) :-
    get(Ps, Index, DocType, ID, _{}, Reply).

get(Ps, Index, DocType, ID, Params, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID], Context),
    perform_request(Ps, get, Context, Params, _, Reply).

%% get_source(+Ps, +Index, +DocType, +ID, -Reply) is semidet.
%% get_source(+Ps, +Index, +DocType, +ID, +Params, -Reply) is semidet.
%
% Get the source of a document by it's index, type and id.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-get_.html).

get_source(Ps, Index, DocType, ID, Reply) :-
    get_source(Ps, Index, DocType, ID, _{}, Reply).

get_source(Ps, Index, DocType, ID, Params, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_source'], Context),
    perform_request(Ps, get, Context, Params, _, Reply).

%% mget(+Ps, +Index, +DocType, -Reply) is semidet.
%% mget(+Ps, +Index, +DocType, +Params, -Reply) is semidet.
%
% Get multiple documents based on an index, type (optional) and ids.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-multi-get.html).

mget(Ps, Index, DocType, Body, Reply) :-
    mget(Ps, Index, DocType, _{}, Body, Reply).

mget(Ps, Index, DocType, Params, Body, Reply) :-
    non_empty(Body, body),
    make_context([Index, DocType, '_mget'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% update(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% update(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% Update a document based on a script or partial data provided.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update.html).

update(Ps, Index, DocType, ID, Body, Reply) :-
    update(Ps, Index, DocType, ID, _{}, Body, Reply).

update(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_update'], Context),
    perform_request(Ps, post, Context, Params, Body, _, Reply).

%% search(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% search(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% Execute a search query and get back search hits that match the query.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html).

search(Ps, Index, DocType, Body, Reply) :-
    search(Ps, Index, DocType, _{}, Body, Reply).

search(Ps, Index, DocType, Params, Body, Reply) :-
    (   Index = '', DocType \= ''
    ->  Index1 = '_all'
    ;   Index1 = Index
    ),
    make_context([Index1, DocType, '_search'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% search_shards(+Ps, +Index, +DocType, -Reply) is semidet.
%% search_shards(+Ps, +Index, +DocType, +Params, -Reply) is semidet.
%
% The search shards api returns the indices and shards that a search
% request would be executed against. This can give useful feedback for working
% out issues or planning optimizations with routing and shard preferences.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/master/search-shards.html).

search_shards(Ps, Index, DocType, Reply) :-
    search_shards(Ps, Index, DocType, _{}, Reply).

search_shards(Ps, Index, DocType, Params, Reply) :-
    make_context([Index, DocType, '_search_shards'], Context),
    perform_request(Ps, get, Context, Params, _, Reply).

%% search_template(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% search_template(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% A query that accepts a query template and a map of key/value pairs to
% fill in template parameters.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/master/query-dsl-template-query.html).

search_template(Ps, Index, DocType, Body, Reply) :-
    search_template(Ps, Index, DocType, _{}, Body, Reply).

search_template(Ps, Index, DocType, Params, Body, Reply) :-
    make_context([Index, DocType, '_search', 'template'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% explain(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% explain(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% The explain api computes a score explanation for a query and a specific
% document. This can give useful feedback whether a document matches or
% didn't match a specific query.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-explain.html).

explain(Ps, Index, DocType, ID, Body, Reply) :-
    explain(Ps, Index, DocType, ID, _{}, Body, Reply).

explain(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_explain'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% scroll(+Ps, +ID, -Reply) is semidet.
%% scroll(+Ps, +ID, +Params, -Reply) is semidet.
%
% Scroll a search request created by specifying the scroll parameter.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-scroll.html).

scroll(Ps, ID, Reply) :-
    scroll(Ps, ID, _{}, Reply).

scroll(Ps, ID, Params, Reply) :-
    perform_request(Ps, get, '/_search/scroll', Params, ID, _, Reply).

%% clear_scroll(+Ps, +ID, -Reply) is semidet.
%% clear_scroll(+Ps, +ID, +Params, -Reply) is semidet.
%
% Clear the scroll request created by specifying the scroll parameter to
% search.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-scroll.html).

clear_scroll(Ps, ID, Body, Reply) :-
    clear_scroll(Ps, ID, _{}, Body, Reply).

clear_scroll(Ps, ID, Params, Body, Reply) :-
    (   var(Body), ID = ''
    ->  ID1 = '_all'
    ;   ID1 = ID
    ),
    make_context(['_search', 'scroll', ID1], Context),
    perform_request(Ps, delete, Context, Params, Body, _, Reply).

%% delete(+Ps, +Index, +DocType, +ID, -Reply) is semidet.
%% delete(+Ps, +Index, +DocType, +ID, +Params, -Reply) is semidet.
%
% Delete a typed JSON document from a specific index based on its id.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete.html).

delete(Ps, Index, DocType, ID, Reply) :-
    delete(Ps, Index, DocType, ID, _{}, Reply).

delete(Ps, Index, DocType, ID, Params, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID], Context),
    perform_request(Ps, delete, Context, Params, _, Reply).

%% count(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% count(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% Execute a query and get the number of matches for that query.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-count.html).

count(Ps, Index, DocType, Body, Reply) :-
    count(Ps, Index, DocType, _{}, Body, Reply).

count(Ps, Index, DocType, Params, Body, Reply) :-
    (   Index = '', DocType \= ''
    ->  Index1 = '_all'
    ;   Index1 = Index
    ),
    make_context([Index1, DocType, '_count'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% bulk(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% bulk(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% Perform many index/delete operations in a single API call.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html).

bulk(Ps, Index, DocType, Body, Reply) :-
    bulk(Ps, Index, DocType, _{}, Body, Reply).

bulk(Ps, Index, DocType, Params, Body, Reply) :-
    non_empty(Body, body),
    make_context([Index, DocType, '_bulk'], Context),
    bulk_body(Body, BulkBody),
    perform_request(Ps, post, Context, Params, BulkBody, _, Reply).

%% msearch(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% msearch(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% Execute several search requests within the same API.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-multi-search.html).

msearch(Ps, Index, DocType, Body, Reply) :-
    msearch(Ps, Index, DocType, _{}, Body, Reply).

msearch(Ps, Index, DocType, Params, Body, Reply) :-
    non_empty(Body, body),
    make_context([Index, DocType, '_msearch'], Context),
    bulk_body(Body, BulkBody),
    perform_request(Ps, get, Context, Params, BulkBody, _, Reply).

%% delete_by_query(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% delete_by_query(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% Delete documents from one or more indices and one or more types based on a query.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete-by-query.html).

delete_by_query(Ps, Index, DocType, Body, Reply) :-
    delete_by_query(Ps, Index, DocType, _{}, Body, Reply).

delete_by_query(Ps, Index, DocType, Params, Body, Reply) :-
    non_empty(Index, index),
    make_context([Index, DocType, '_query'], Context),
    perform_request(Ps, delete, Context, Params, Body, _, Reply).

%% suggest(+Ps, +Index, +Body, -Reply) is semidet.
%% suggest(+Ps, +Index, +Params, +Body, -Reply) is semidet.
%
% The suggest feature suggests similar looking terms based on a provided
% text by using a suggester.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-search.html).

suggest(Ps, Index, Body, Reply) :-
    suggest(Ps, Index, _{}, Body, Reply).

suggest(Ps, Index, Params, Body, Reply) :-
    non_empty(Body, body),
    make_context([Index, '_suggest'], Context),
    perform_request(Ps, post, Context, Params, Body, _, Reply).

%% percolate(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% percolate(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% The percolator allows to register queries against an index, and then
% send percolate requests which include a doc, and getting back the
% queries that match on that doc out of the set of registered queries.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-percolate.html).

percolate(Ps, Index, DocType, ID, Body, Reply) :-
    percolate(Ps, Index, DocType, ID, _{}, Body, Reply).

percolate(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_percolate'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% mpercolate(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% mpercolate(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% The percolator allows to register queries against an index, and then
% send percolate requests which include a doc, and getting back the
% queries that match on that doc out of the set of registered queries.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-percolate.html).

mpercolate(Ps, Index, DocType, Body, Reply) :-
    mpercolate(Ps, Index, DocType, _{}, Body, Reply).

mpercolate(Ps, Index, DocType, Params, Body, Reply) :-
    non_empty(Body, body),
    make_context([Index, DocType, '_mpercolate'], Context),
    bulk_body(Body, BulkBody),
    perform_request(Ps, get, Context, Params, BulkBody, _, Reply).

%% count_percolate(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% count_percolate(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% The percolator allows to register queries against an index, and then
% send percolate requests which include a doc, and getting back the
% queries that match on that doc out of the set of registered queries.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-percolate.html).

count_percolate(Ps, Index, DocType, ID, Body, Reply) :-
    count_percolate(Ps, Index, DocType, ID, _{}, Body, Reply).

count_percolate(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_percolate', count], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% mlt(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% mlt(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% Get documents that are "like" a specified document.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-more-like-this.html).

mlt(Ps, Index, DocType, ID, Body, Reply) :-
    mlt(Ps, Index, DocType, ID, _{}, Body, Reply).

mlt(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_mlt'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% termvectors(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% termvectors(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% Returns information and statistics on terms in the fields of a
% particular document. The document could be stored in the index or
% artificially provided by the user (Added in 1.4). Note that for
% documents stored in the index, this is a near realtime API as the term
% vectors are not available until the next refresh.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-termvectors.html).

termvectors(Ps, Index, DocType, ID, Body, Reply) :-
    termvectors(Ps, Index, DocType, ID, _{}, Body, Reply).

termvectors(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_termvectors'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% termvector(+Ps, +Index, +DocType, +ID, +Body, -Reply) is semidet.
%% termvector(+Ps, +Index, +DocType, +ID, +Params, +Body, -Reply) is semidet.
%
% Returns information and statistics on terms in the fields of a
% particular document. The document could be stored in the index or
% artificially provided by the user (Added in 1.4). Note that for
% documents stored in the index, this is a near realtime API as the term
% vectors are not available until the next refresh.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/docs-termvectors.html).

termvector(Ps, Index, DocType, ID, Body, Reply) :-
    termvector(Ps, Index, DocType, ID, _{}, Body, Reply).

termvector(Ps, Index, DocType, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Index-index, DocType-doc_type, ID-id]), non_empty(Value, Name)),
    make_context([Index, DocType, ID, '_termvector'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% mtermvectors(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% mtermvectors(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% Multi termvectors API allows to get multiple termvectors based on an
% index, type and id.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/master/docs-multi-termvectors.html).

mtermvectors(Ps, Index, DocType, Body, Reply) :-
    mtermvectors(Ps, Index, DocType, _{}, Body, Reply).

mtermvectors(Ps, Index, DocType, Params, Body, Reply) :-
    make_context([Index, DocType, '_mtermvectors'], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

%% benchmark(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% benchmark(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% The benchmark API provides a standard mechanism for submitting queries
% and measuring their performance relative to one another.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/master/search-benchmark.html).

benchmark(Ps, Index, DocType, Body, Reply) :-
    benchmark(Ps, Index, DocType, _{}, Body, Reply).

benchmark(Ps, Index, DocType, Params, Body, Reply) :-
    make_context([Index, DocType, '_bench'], Context),
    perform_request(Ps, put, Context, Params, Body, _, Reply).

%% abort_benchmark(+Ps, +Name, -Reply) is semidet.
%% abort_benchmark(+Ps, +Name, +Params, -Reply) is semidet.
%
% Aborts a running benchmark.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/master/search-benchmark.html).

abort_benchmark(Ps, Name, Reply) :-
    abort_benchmark(Ps, Name, _{}, Reply).

abort_benchmark(Ps, Name, Params, Reply) :-
    make_context(['_bench', abort, Name], Context),
    perform_request(Ps, post, Context, Params, _, _, Reply).

%% list_benchmark(+Ps, +Index, +DocType, -Reply) is semidet.
%% list_benchmark(+Ps, +Index, +DocType, +Params, -Reply) is semidet.
%
% View the progress of long-running benchmarks.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/master/search-benchmark.html).

list_benchmark(Ps, Index, DocType, Reply) :-
    list_benchmark(Ps, Index, DocType, _{}, Reply).

list_benchmark(Ps, Index, DocType, Params, Reply) :-
    make_context([Index, DocType, '_bench'], Context),
    perform_request(Ps, get, Context, Params, _, Reply).

%% put_script(+Ps, +Lang, +ID, +Body, -Reply) is semidet.
%% put_script(+Ps, +Lang, +ID, +Params, +Body, -Reply) is semidet.
%
% Create a script in given language with specified ID.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting.html).

put_script(Ps, Lang, ID, Body, Reply) :-
    put_script(Ps, Lang, ID, _{}, Body, Reply).

put_script(Ps, Lang, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [Lang-lang, ID-id, Body-body]), non_empty(Value, Name)),
    make_context(['_scripts', Lang, ID], Context),
    perform_request(Ps, put, Context, Params, Body, _, Reply).

%% get_script(+Ps, +Lang, +ID, -Reply) is semidet.
%% get_script(+Ps, +Lang, +ID, +Params, -Reply) is semidet.
%
% Retrieve a script from the API.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting.html).

get_script(Ps, Lang, ID, Reply) :-
    get_script(Ps, Lang, ID, _{}, Reply).

get_script(Ps, Lang, ID, Params, Reply) :-
    forall(member(Value-Name, [Lang-lang, ID-id]), non_empty(Value, Name)),
    make_context(['_scripts', Lang, ID], Context),
    perform_request(Ps, get, Context, Params, _, Reply).

%% delete_script(+Ps, +Lang, +ID, -Reply) is semidet.
%% delete_script(+Ps, +Lang, +ID, +Params, -Reply) is semidet.
%
% Remove a stored script from elasticsearch.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-scripting.html).

delete_script(Ps, Lang, ID, Reply) :-
    delete_script(Ps, Lang, ID, _{}, Reply).

delete_script(Ps, Lang, ID, Params, Reply) :-
    forall(member(Value-Name, [Lang-lang, ID-id]), non_empty(Value, Name)),
    make_context(['_scripts', Lang, ID], Context),
    perform_request(Ps, delete, Context, Params, _, Reply).

%% put_template(+Ps, +ID, +Body, -Reply) is semidet.
%% put_template(+Ps, +ID, +Params, +Body, -Reply) is semidet.
%
% Create a search template.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-template.html).

put_template(Ps, ID, Body, Reply) :-
    put_template(Ps, ID, _{}, Body, Reply).

put_template(Ps, ID, Params, Body, Reply) :-
    forall(member(Value-Name, [ID-id, Body-body]), non_empty(Value, Name)),
    make_context(['_search', template, ID], Context),
    perform_request(Ps, put, Context, Params, Body, _, Reply).

%% get_template(+Ps, +ID, -Reply) is semidet.
%% get_template(+Ps, +ID, +Params, -Reply) is semidet.
%
% Retrieve a search template.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-template.html).

get_template(Ps, ID, Reply) :-
    get_template(Ps, ID, _{}, Reply).

get_template(Ps, ID, Params, Reply) :-
    non_empty(ID, id),
    make_context(['_search', template, ID], Context),
    perform_request(Ps, get, Context, Params, _, Reply).

%% delete_template(+Ps, +ID, -Reply) is semidet.
%% delete_template(+Ps, +ID, +Params, -Reply) is semidet.
%
% Delete a search template.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-template.html).

delete_template(Ps, ID, Reply) :-
    delete_template(Ps, ID, _{}, Reply).

delete_template(Ps, ID, Params, Reply) :-
    make_context(['_search', template, ID], Context),
    perform_request(Ps, delete, Context, Params, _, Reply).

%% search_exists(+Ps, +Index, +DocType, +Body, -Reply) is semidet.
%% search_exists(+Ps, +Index, +DocType, +Params, +Body, -Reply) is semidet.
%
% The exists API allows to easily determine if any matching documents
% exist for a provided query.
% See [here](http://www.elastic.co/guide/en/elasticsearch/reference/current/search-exists.html).

search_exists(Ps, Index, DocType, Body, Reply) :-
    search_exists(Ps, Index, DocType, _{}, Body, Reply).

search_exists(Ps, Index, DocType, Params, Body, Reply) :-
    make_context([Index, DocType, '_search', exists], Context),
    perform_request(Ps, get, Context, Params, Body, _, Reply).

bulk_body(Body, BulkBody) :-
    atom(Body), !,
    (   sub_atom(Body, _, 1, 0, '\n')
    ->  BulkBody = Body
    ;   atomic_concat(Body, '\n', BulkBody)
    ).

bulk_body(Body, BulkBody) :-
    is_dict(Body), !,
    atom_json_dict(BulkBody, Body, [as(atom)]).

bulk_body([], '') :- !.
bulk_body([H|T], BulkBody) :- !,
    bulk_body(T, BulkBody0),
    bulk_body(H, BulkBody1),
    atomic_list_concat([BulkBody1, BulkBody0], '\n', BulkBody).
