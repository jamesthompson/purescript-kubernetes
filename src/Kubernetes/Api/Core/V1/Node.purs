module Kubernetes.Api.Core.V1.Node where

import Prelude
import Control.Monad.Aff (Aff)
import Data.Either (Either(Left,Right))
import Data.Foreign.Class (class Decode, class Encode, encode, decode)
import Data.Foreign.Generic (encodeJSON, genericEncode, genericDecode)
import Data.Foreign.Index (readProp)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(Just,Nothing))
import Data.Newtype (class Newtype)
import Data.StrMap (StrMap)
import Data.StrMap as StrMap
import Data.Tuple (Tuple(Tuple))
import Kubernetes.Client as Client
import Kubernetes.Config (Config)
import Kubernetes.Default (class Default)
import Kubernetes.Json (assertPropEq, decodeMaybe, encodeMaybe, jsonOptions)
import Node.HTTP (HTTP)
import Kubernetes.Api.Core.V1 as CoreV1
import Kubernetes.Api.Meta.V1 as MetaV1

-- | connect DELETE requests to proxy of Node
connectDeleteProxy :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectDeleteProxy cfg name = Client.makeRequest (Client.delete cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy"

-- | connect DELETE requests to proxy of Node
connectDeleteProxyWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectDeleteProxyWithPath cfg name path = Client.makeRequest (Client.delete cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy/" <> path <> ""

-- | connect GET requests to proxy of Node
connectGetProxy :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectGetProxy cfg name = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy"

-- | connect GET requests to proxy of Node
connectGetProxyWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectGetProxyWithPath cfg name path = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy/" <> path <> ""

-- | connect HEAD requests to proxy of Node
connectHeadProxy :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectHeadProxy cfg name = Client.makeRequest (Client.head cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy"

-- | connect HEAD requests to proxy of Node
connectHeadProxyWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectHeadProxyWithPath cfg name path = Client.makeRequest (Client.head cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy/" <> path <> ""

-- | connect OPTIONS requests to proxy of Node
connectOptionsProxy :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectOptionsProxy cfg name = Client.makeRequest (Client.options cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy"

-- | connect OPTIONS requests to proxy of Node
connectOptionsProxyWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectOptionsProxyWithPath cfg name path = Client.makeRequest (Client.options cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy/" <> path <> ""

-- | connect POST requests to proxy of Node
connectPostProxy :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectPostProxy cfg name = Client.makeRequest (Client.post cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy"

-- | connect POST requests to proxy of Node
connectPostProxyWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectPostProxyWithPath cfg name path = Client.makeRequest (Client.post cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy/" <> path <> ""

-- | connect PUT requests to proxy of Node
connectPutProxy :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectPutProxy cfg name = Client.makeRequest (Client.put cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy"

-- | connect PUT requests to proxy of Node
connectPutProxyWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
connectPutProxyWithPath cfg name path = Client.makeRequest (Client.put cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/proxy/" <> path <> ""

-- | create a Node
create :: forall e. Config -> CoreV1.Node -> Aff (http :: HTTP | e) (Either MetaV1.Status CoreV1.Node)
create cfg body = Client.makeRequest (Client.post cfg url (Just encodedBody))
  where
    url = "/api/v1/nodes"
    encodedBody = encodeJSON body

-- | Fields:
-- | - `gracePeriodSeconds`: The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately.
-- | - `orphanDependents`: Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the "orphan" finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both.
-- | - `propagationPolicy`: Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground.
newtype DeleteOptions = DeleteOptions
  { gracePeriodSeconds :: (Maybe Int)
  , orphanDependents :: (Maybe Boolean)
  , propagationPolicy :: (Maybe String) }

derive instance newtypeDeleteOptions :: Newtype DeleteOptions _
derive instance genericDeleteOptions :: Generic DeleteOptions _
instance showDeleteOptions :: Show DeleteOptions where show a = genericShow a
instance decodeDeleteOptions :: Decode DeleteOptions where
  decode a = do
               gracePeriodSeconds <- decodeMaybe "gracePeriodSeconds" a
               orphanDependents <- decodeMaybe "orphanDependents" a
               propagationPolicy <- decodeMaybe "propagationPolicy" a
               pure $ DeleteOptions { gracePeriodSeconds, orphanDependents, propagationPolicy }
instance encodeDeleteOptions :: Encode DeleteOptions where
  encode (DeleteOptions a) = encode $ StrMap.fromFoldable $
               [ Tuple "gracePeriodSeconds" (encodeMaybe a.gracePeriodSeconds)
               , Tuple "orphanDependents" (encodeMaybe a.orphanDependents)
               , Tuple "propagationPolicy" (encodeMaybe a.propagationPolicy) ]


instance defaultDeleteOptions :: Default DeleteOptions where
  default = DeleteOptions
    { gracePeriodSeconds: Nothing
    , orphanDependents: Nothing
    , propagationPolicy: Nothing }

-- | delete a Node
delete :: forall e. Config -> String -> MetaV1.DeleteOptions -> DeleteOptions -> Aff (http :: HTTP | e) (Either MetaV1.Status MetaV1.Status)
delete cfg name body options = Client.makeRequest (Client.delete cfg url (Just encodedBody))
  where
    url = "/api/v1/nodes/" <> name <> "" <> Client.formatQueryString options
    encodedBody = encodeJSON body

-- | Fields:
-- | - `continue`: The continue option should be set when retrieving more results from the server. Since this value is server defined, clients may only use the continue value from a previous query result with identical query parameters (except for the value of continue) and the server may reject a continue value it does not recognize. If the specified continue value is no longer valid whether due to expiration (generally five to fifteen minutes) or a configuration change on the server the server will respond with a 410 ResourceExpired error indicating the client must restart their list without the continue field. This field is not supported when watch is true. Clients may start a watch from the last resourceVersion value returned by the server and not miss any modifications.
-- | - `fieldSelector`: A selector to restrict the list of returned objects by their fields. Defaults to everything.
-- | - `includeUninitialized`: If true, partially initialized resources are included in the response.
-- | - `labelSelector`: A selector to restrict the list of returned objects by their labels. Defaults to everything.
-- | - `limit`: limit is a maximum number of responses to return for a list call. If more items exist, the server will set the `continue` field on the list metadata to a value that can be used with the same initial query to retrieve the next set of results. Setting a limit may return fewer than the requested amount of items (up to zero items) in the event all requested objects are filtered out and clients should only use the presence of the continue field to determine whether more results are available. Servers may choose not to support the limit argument and will return all of the available results. If limit is specified and the continue field is empty, clients may assume that no more results are available. This field is not supported if watch is true.
-- |    
-- |    The server guarantees that the objects returned when using continue will be identical to issuing a single list call without a limit - that is, no objects created, modified, or deleted after the first request is issued will be included in any subsequent continued requests. This is sometimes referred to as a consistent snapshot, and ensures that a client that is using limit to receive smaller chunks of a very large result can ensure they see all possible objects. If objects are updated during a chunked list the version of the object that was present at the time the first list result was calculated is returned.
-- | - `resourceVersion`: When specified with a watch call, shows changes that occur after that particular version of a resource. Defaults to changes from the beginning of history. When specified for list: - if unset, then the result is returned from remote storage based on quorum-read flag; - if it's 0, then we simply return what we currently have in cache, no guarantee; - if set to non zero, then the result is at least as fresh as given rv.
-- | - `timeoutSeconds`: Timeout for the list/watch call.
-- | - `watch`: Watch for changes to the described resources and return them as a stream of add, update, and remove notifications. Specify resourceVersion.
newtype DeleteCollectionOptions = DeleteCollectionOptions
  { continue :: (Maybe String)
  , fieldSelector :: (Maybe String)
  , includeUninitialized :: (Maybe Boolean)
  , labelSelector :: (Maybe String)
  , limit :: (Maybe Int)
  , resourceVersion :: (Maybe String)
  , timeoutSeconds :: (Maybe Int)
  , watch :: (Maybe Boolean) }

derive instance newtypeDeleteCollectionOptions :: Newtype DeleteCollectionOptions _
derive instance genericDeleteCollectionOptions :: Generic DeleteCollectionOptions _
instance showDeleteCollectionOptions :: Show DeleteCollectionOptions where show a = genericShow a
instance decodeDeleteCollectionOptions :: Decode DeleteCollectionOptions where
  decode a = do
               continue <- decodeMaybe "continue" a
               fieldSelector <- decodeMaybe "fieldSelector" a
               includeUninitialized <- decodeMaybe "includeUninitialized" a
               labelSelector <- decodeMaybe "labelSelector" a
               limit <- decodeMaybe "limit" a
               resourceVersion <- decodeMaybe "resourceVersion" a
               timeoutSeconds <- decodeMaybe "timeoutSeconds" a
               watch <- decodeMaybe "watch" a
               pure $ DeleteCollectionOptions { continue, fieldSelector, includeUninitialized, labelSelector, limit, resourceVersion, timeoutSeconds, watch }
instance encodeDeleteCollectionOptions :: Encode DeleteCollectionOptions where
  encode (DeleteCollectionOptions a) = encode $ StrMap.fromFoldable $
               [ Tuple "continue" (encodeMaybe a.continue)
               , Tuple "fieldSelector" (encodeMaybe a.fieldSelector)
               , Tuple "includeUninitialized" (encodeMaybe a.includeUninitialized)
               , Tuple "labelSelector" (encodeMaybe a.labelSelector)
               , Tuple "limit" (encodeMaybe a.limit)
               , Tuple "resourceVersion" (encodeMaybe a.resourceVersion)
               , Tuple "timeoutSeconds" (encodeMaybe a.timeoutSeconds)
               , Tuple "watch" (encodeMaybe a.watch) ]


instance defaultDeleteCollectionOptions :: Default DeleteCollectionOptions where
  default = DeleteCollectionOptions
    { continue: Nothing
    , fieldSelector: Nothing
    , includeUninitialized: Nothing
    , labelSelector: Nothing
    , limit: Nothing
    , resourceVersion: Nothing
    , timeoutSeconds: Nothing
    , watch: Nothing }

-- | delete collection of Node
deleteCollection :: forall e. Config -> DeleteCollectionOptions -> Aff (http :: HTTP | e) (Either MetaV1.Status MetaV1.Status)
deleteCollection cfg options = Client.makeRequest (Client.delete cfg url Nothing)
  where
    url = "/api/v1/nodes" <> Client.formatQueryString options

-- | Fields:
-- | - `continue`: The continue option should be set when retrieving more results from the server. Since this value is server defined, clients may only use the continue value from a previous query result with identical query parameters (except for the value of continue) and the server may reject a continue value it does not recognize. If the specified continue value is no longer valid whether due to expiration (generally five to fifteen minutes) or a configuration change on the server the server will respond with a 410 ResourceExpired error indicating the client must restart their list without the continue field. This field is not supported when watch is true. Clients may start a watch from the last resourceVersion value returned by the server and not miss any modifications.
-- | - `fieldSelector`: A selector to restrict the list of returned objects by their fields. Defaults to everything.
-- | - `includeUninitialized`: If true, partially initialized resources are included in the response.
-- | - `labelSelector`: A selector to restrict the list of returned objects by their labels. Defaults to everything.
-- | - `limit`: limit is a maximum number of responses to return for a list call. If more items exist, the server will set the `continue` field on the list metadata to a value that can be used with the same initial query to retrieve the next set of results. Setting a limit may return fewer than the requested amount of items (up to zero items) in the event all requested objects are filtered out and clients should only use the presence of the continue field to determine whether more results are available. Servers may choose not to support the limit argument and will return all of the available results. If limit is specified and the continue field is empty, clients may assume that no more results are available. This field is not supported if watch is true.
-- |    
-- |    The server guarantees that the objects returned when using continue will be identical to issuing a single list call without a limit - that is, no objects created, modified, or deleted after the first request is issued will be included in any subsequent continued requests. This is sometimes referred to as a consistent snapshot, and ensures that a client that is using limit to receive smaller chunks of a very large result can ensure they see all possible objects. If objects are updated during a chunked list the version of the object that was present at the time the first list result was calculated is returned.
-- | - `resourceVersion`: When specified with a watch call, shows changes that occur after that particular version of a resource. Defaults to changes from the beginning of history. When specified for list: - if unset, then the result is returned from remote storage based on quorum-read flag; - if it's 0, then we simply return what we currently have in cache, no guarantee; - if set to non zero, then the result is at least as fresh as given rv.
-- | - `timeoutSeconds`: Timeout for the list/watch call.
-- | - `watch`: Watch for changes to the described resources and return them as a stream of add, update, and remove notifications. Specify resourceVersion.
newtype ListOptions = ListOptions
  { continue :: (Maybe String)
  , fieldSelector :: (Maybe String)
  , includeUninitialized :: (Maybe Boolean)
  , labelSelector :: (Maybe String)
  , limit :: (Maybe Int)
  , resourceVersion :: (Maybe String)
  , timeoutSeconds :: (Maybe Int)
  , watch :: (Maybe Boolean) }

derive instance newtypeListOptions :: Newtype ListOptions _
derive instance genericListOptions :: Generic ListOptions _
instance showListOptions :: Show ListOptions where show a = genericShow a
instance decodeListOptions :: Decode ListOptions where
  decode a = do
               continue <- decodeMaybe "continue" a
               fieldSelector <- decodeMaybe "fieldSelector" a
               includeUninitialized <- decodeMaybe "includeUninitialized" a
               labelSelector <- decodeMaybe "labelSelector" a
               limit <- decodeMaybe "limit" a
               resourceVersion <- decodeMaybe "resourceVersion" a
               timeoutSeconds <- decodeMaybe "timeoutSeconds" a
               watch <- decodeMaybe "watch" a
               pure $ ListOptions { continue, fieldSelector, includeUninitialized, labelSelector, limit, resourceVersion, timeoutSeconds, watch }
instance encodeListOptions :: Encode ListOptions where
  encode (ListOptions a) = encode $ StrMap.fromFoldable $
               [ Tuple "continue" (encodeMaybe a.continue)
               , Tuple "fieldSelector" (encodeMaybe a.fieldSelector)
               , Tuple "includeUninitialized" (encodeMaybe a.includeUninitialized)
               , Tuple "labelSelector" (encodeMaybe a.labelSelector)
               , Tuple "limit" (encodeMaybe a.limit)
               , Tuple "resourceVersion" (encodeMaybe a.resourceVersion)
               , Tuple "timeoutSeconds" (encodeMaybe a.timeoutSeconds)
               , Tuple "watch" (encodeMaybe a.watch) ]


instance defaultListOptions :: Default ListOptions where
  default = ListOptions
    { continue: Nothing
    , fieldSelector: Nothing
    , includeUninitialized: Nothing
    , labelSelector: Nothing
    , limit: Nothing
    , resourceVersion: Nothing
    , timeoutSeconds: Nothing
    , watch: Nothing }

-- | list or watch objects of kind Node
list :: forall e. Config -> ListOptions -> Aff (http :: HTTP | e) (Either MetaV1.Status CoreV1.NodeList)
list cfg options = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/nodes" <> Client.formatQueryString options

-- | proxy DELETE requests to Node
proxyDELETE :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyDELETE cfg name = Client.makeRequest (Client.delete cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> ""

-- | proxy DELETE requests to Node
proxyDELETEWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyDELETEWithPath cfg name path = Client.makeRequest (Client.delete cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> "/" <> path <> ""

-- | proxy GET requests to Node
proxyGET :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyGET cfg name = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> ""

-- | proxy GET requests to Node
proxyGETWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyGETWithPath cfg name path = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> "/" <> path <> ""

-- | proxy HEAD requests to Node
proxyHEAD :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyHEAD cfg name = Client.makeRequest (Client.head cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> ""

-- | proxy HEAD requests to Node
proxyHEADWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyHEADWithPath cfg name path = Client.makeRequest (Client.head cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> "/" <> path <> ""

-- | proxy OPTIONS requests to Node
proxyOPTIONS :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyOPTIONS cfg name = Client.makeRequest (Client.options cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> ""

-- | proxy OPTIONS requests to Node
proxyOPTIONSWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyOPTIONSWithPath cfg name path = Client.makeRequest (Client.options cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> "/" <> path <> ""

-- | proxy POST requests to Node
proxyPOST :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyPOST cfg name = Client.makeRequest (Client.post cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> ""

-- | proxy POST requests to Node
proxyPOSTWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyPOSTWithPath cfg name path = Client.makeRequest (Client.post cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> "/" <> path <> ""

-- | proxy PUT requests to Node
proxyPUT :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyPUT cfg name = Client.makeRequest (Client.put cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> ""

-- | proxy PUT requests to Node
proxyPUTWithPath :: forall e. Config -> String -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status String)
proxyPUTWithPath cfg name path = Client.makeRequest (Client.put cfg url Nothing)
  where
    url = "/api/v1/proxy/nodes/" <> name <> "/" <> path <> ""

-- | Fields:
-- | - `exact`: Should the export be exact.  Exact export maintains cluster-specific fields like 'Namespace'.
-- | - `export`: Should this value be exported.  Export strips fields that a user can not specify.
newtype ReadOptions = ReadOptions
  { exact :: (Maybe Boolean)
  , export :: (Maybe Boolean) }

derive instance newtypeReadOptions :: Newtype ReadOptions _
derive instance genericReadOptions :: Generic ReadOptions _
instance showReadOptions :: Show ReadOptions where show a = genericShow a
instance decodeReadOptions :: Decode ReadOptions where
  decode a = do
               exact <- decodeMaybe "exact" a
               export <- decodeMaybe "export" a
               pure $ ReadOptions { exact, export }
instance encodeReadOptions :: Encode ReadOptions where
  encode (ReadOptions a) = encode $ StrMap.fromFoldable $
               [ Tuple "exact" (encodeMaybe a.exact)
               , Tuple "export" (encodeMaybe a.export) ]


instance defaultReadOptions :: Default ReadOptions where
  default = ReadOptions
    { exact: Nothing
    , export: Nothing }

-- | read the specified Node
read :: forall e. Config -> String -> ReadOptions -> Aff (http :: HTTP | e) (Either MetaV1.Status CoreV1.Node)
read cfg name options = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "" <> Client.formatQueryString options

-- | read status of the specified Node
readStatus :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status CoreV1.Node)
readStatus cfg name = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/nodes/" <> name <> "/status"

-- | replace the specified Node
replace :: forall e. Config -> String -> CoreV1.Node -> Aff (http :: HTTP | e) (Either MetaV1.Status CoreV1.Node)
replace cfg name body = Client.makeRequest (Client.put cfg url (Just encodedBody))
  where
    url = "/api/v1/nodes/" <> name <> ""
    encodedBody = encodeJSON body

-- | replace status of the specified Node
replaceStatus :: forall e. Config -> String -> CoreV1.Node -> Aff (http :: HTTP | e) (Either MetaV1.Status CoreV1.Node)
replaceStatus cfg name body = Client.makeRequest (Client.put cfg url (Just encodedBody))
  where
    url = "/api/v1/nodes/" <> name <> "/status"
    encodedBody = encodeJSON body

-- | watch changes to an object of kind Node
watch :: forall e. Config -> String -> Aff (http :: HTTP | e) (Either MetaV1.Status MetaV1.WatchEvent)
watch cfg name = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/watch/nodes/" <> name <> ""

-- | watch individual changes to a list of Node
watchList :: forall e. Config -> Aff (http :: HTTP | e) (Either MetaV1.Status MetaV1.WatchEvent)
watchList cfg = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/api/v1/watch/nodes"