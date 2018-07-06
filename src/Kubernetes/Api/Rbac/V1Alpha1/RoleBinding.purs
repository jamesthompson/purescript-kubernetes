module Kubernetes.Api.Rbac.V1Alpha1.RoleBinding where

import Prelude
import Prelude
import Data.Either (Either(Left,Right))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(Just,Nothing))
import Data.Newtype (class Newtype)
import Data.Tuple (Tuple(Tuple))
import Effect.Aff (Aff)
import Foreign.Class (class Decode, class Encode, encode, decode)
import Foreign.Generic (encodeJSON, genericEncode, genericDecode)
import Foreign.Index (readProp)
import Foreign.Object (Object)
import Foreign.Object as Object
import Kubernetes.Client as Client
import Kubernetes.Config (Config)
import Kubernetes.Default (class Default)
import Kubernetes.Json (assertPropEq, decodeMaybe, encodeMaybe, jsonOptions)
import Kubernetes.Api.Meta.V1 as MetaV1
import Kubernetes.Api.Rbac.V1Alpha1 as RbacV1Alpha1

-- | create a RoleBinding
createNamespaced :: Config -> RbacV1Alpha1.RoleBinding -> Aff (Either MetaV1.Status RbacV1Alpha1.RoleBinding)
createNamespaced cfg body = Client.makeRequest (Client.post cfg url (Just encodedBody))
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings"
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
newtype DeleteCollectionNamespacedOptions = DeleteCollectionNamespacedOptions
  { continue :: (Maybe String)
  , fieldSelector :: (Maybe String)
  , includeUninitialized :: (Maybe Boolean)
  , labelSelector :: (Maybe String)
  , limit :: (Maybe Int)
  , resourceVersion :: (Maybe String)
  , timeoutSeconds :: (Maybe Int)
  , watch :: (Maybe Boolean) }

derive instance newtypeDeleteCollectionNamespacedOptions :: Newtype DeleteCollectionNamespacedOptions _
derive instance genericDeleteCollectionNamespacedOptions :: Generic DeleteCollectionNamespacedOptions _
instance showDeleteCollectionNamespacedOptions :: Show DeleteCollectionNamespacedOptions where show a = genericShow a
instance decodeDeleteCollectionNamespacedOptions :: Decode DeleteCollectionNamespacedOptions where
  decode a = do
               continue <- decodeMaybe "continue" a
               fieldSelector <- decodeMaybe "fieldSelector" a
               includeUninitialized <- decodeMaybe "includeUninitialized" a
               labelSelector <- decodeMaybe "labelSelector" a
               limit <- decodeMaybe "limit" a
               resourceVersion <- decodeMaybe "resourceVersion" a
               timeoutSeconds <- decodeMaybe "timeoutSeconds" a
               watch <- decodeMaybe "watch" a
               pure $ DeleteCollectionNamespacedOptions { continue, fieldSelector, includeUninitialized, labelSelector, limit, resourceVersion, timeoutSeconds, watch }
instance encodeDeleteCollectionNamespacedOptions :: Encode DeleteCollectionNamespacedOptions where
  encode (DeleteCollectionNamespacedOptions a) = encode $ Object.fromFoldable $
               [ Tuple "continue" (encodeMaybe a.continue)
               , Tuple "fieldSelector" (encodeMaybe a.fieldSelector)
               , Tuple "includeUninitialized" (encodeMaybe a.includeUninitialized)
               , Tuple "labelSelector" (encodeMaybe a.labelSelector)
               , Tuple "limit" (encodeMaybe a.limit)
               , Tuple "resourceVersion" (encodeMaybe a.resourceVersion)
               , Tuple "timeoutSeconds" (encodeMaybe a.timeoutSeconds)
               , Tuple "watch" (encodeMaybe a.watch) ]


instance defaultDeleteCollectionNamespacedOptions :: Default DeleteCollectionNamespacedOptions where
  default = DeleteCollectionNamespacedOptions
    { continue: Nothing
    , fieldSelector: Nothing
    , includeUninitialized: Nothing
    , labelSelector: Nothing
    , limit: Nothing
    , resourceVersion: Nothing
    , timeoutSeconds: Nothing
    , watch: Nothing }

-- | delete collection of RoleBinding
deleteCollectionNamespaced :: Config -> DeleteCollectionNamespacedOptions -> Aff (Either MetaV1.Status MetaV1.Status)
deleteCollectionNamespaced cfg options = Client.makeRequest (Client.delete cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings" <> Client.formatQueryString options

-- | Fields:
-- | - `gracePeriodSeconds`: The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately.
-- | - `orphanDependents`: Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the "orphan" finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both.
-- | - `propagationPolicy`: Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground.
newtype DeleteNamespacedOptions = DeleteNamespacedOptions
  { gracePeriodSeconds :: (Maybe Int)
  , orphanDependents :: (Maybe Boolean)
  , propagationPolicy :: (Maybe String) }

derive instance newtypeDeleteNamespacedOptions :: Newtype DeleteNamespacedOptions _
derive instance genericDeleteNamespacedOptions :: Generic DeleteNamespacedOptions _
instance showDeleteNamespacedOptions :: Show DeleteNamespacedOptions where show a = genericShow a
instance decodeDeleteNamespacedOptions :: Decode DeleteNamespacedOptions where
  decode a = do
               gracePeriodSeconds <- decodeMaybe "gracePeriodSeconds" a
               orphanDependents <- decodeMaybe "orphanDependents" a
               propagationPolicy <- decodeMaybe "propagationPolicy" a
               pure $ DeleteNamespacedOptions { gracePeriodSeconds, orphanDependents, propagationPolicy }
instance encodeDeleteNamespacedOptions :: Encode DeleteNamespacedOptions where
  encode (DeleteNamespacedOptions a) = encode $ Object.fromFoldable $
               [ Tuple "gracePeriodSeconds" (encodeMaybe a.gracePeriodSeconds)
               , Tuple "orphanDependents" (encodeMaybe a.orphanDependents)
               , Tuple "propagationPolicy" (encodeMaybe a.propagationPolicy) ]


instance defaultDeleteNamespacedOptions :: Default DeleteNamespacedOptions where
  default = DeleteNamespacedOptions
    { gracePeriodSeconds: Nothing
    , orphanDependents: Nothing
    , propagationPolicy: Nothing }

-- | delete a RoleBinding
deleteNamespaced :: Config -> MetaV1.DeleteOptions -> DeleteNamespacedOptions -> Aff (Either MetaV1.Status MetaV1.Status)
deleteNamespaced cfg body options = Client.makeRequest (Client.delete cfg url (Just encodedBody))
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings/{name}" <> Client.formatQueryString options
    encodedBody = encodeJSON body

-- | list or watch objects of kind RoleBinding
listForAllNamespaces :: Config -> Aff (Either MetaV1.Status RbacV1Alpha1.RoleBindingList)
listForAllNamespaces cfg = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/rolebindings"

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
newtype ListNamespacedOptions = ListNamespacedOptions
  { continue :: (Maybe String)
  , fieldSelector :: (Maybe String)
  , includeUninitialized :: (Maybe Boolean)
  , labelSelector :: (Maybe String)
  , limit :: (Maybe Int)
  , resourceVersion :: (Maybe String)
  , timeoutSeconds :: (Maybe Int)
  , watch :: (Maybe Boolean) }

derive instance newtypeListNamespacedOptions :: Newtype ListNamespacedOptions _
derive instance genericListNamespacedOptions :: Generic ListNamespacedOptions _
instance showListNamespacedOptions :: Show ListNamespacedOptions where show a = genericShow a
instance decodeListNamespacedOptions :: Decode ListNamespacedOptions where
  decode a = do
               continue <- decodeMaybe "continue" a
               fieldSelector <- decodeMaybe "fieldSelector" a
               includeUninitialized <- decodeMaybe "includeUninitialized" a
               labelSelector <- decodeMaybe "labelSelector" a
               limit <- decodeMaybe "limit" a
               resourceVersion <- decodeMaybe "resourceVersion" a
               timeoutSeconds <- decodeMaybe "timeoutSeconds" a
               watch <- decodeMaybe "watch" a
               pure $ ListNamespacedOptions { continue, fieldSelector, includeUninitialized, labelSelector, limit, resourceVersion, timeoutSeconds, watch }
instance encodeListNamespacedOptions :: Encode ListNamespacedOptions where
  encode (ListNamespacedOptions a) = encode $ Object.fromFoldable $
               [ Tuple "continue" (encodeMaybe a.continue)
               , Tuple "fieldSelector" (encodeMaybe a.fieldSelector)
               , Tuple "includeUninitialized" (encodeMaybe a.includeUninitialized)
               , Tuple "labelSelector" (encodeMaybe a.labelSelector)
               , Tuple "limit" (encodeMaybe a.limit)
               , Tuple "resourceVersion" (encodeMaybe a.resourceVersion)
               , Tuple "timeoutSeconds" (encodeMaybe a.timeoutSeconds)
               , Tuple "watch" (encodeMaybe a.watch) ]


instance defaultListNamespacedOptions :: Default ListNamespacedOptions where
  default = ListNamespacedOptions
    { continue: Nothing
    , fieldSelector: Nothing
    , includeUninitialized: Nothing
    , labelSelector: Nothing
    , limit: Nothing
    , resourceVersion: Nothing
    , timeoutSeconds: Nothing
    , watch: Nothing }

-- | list or watch objects of kind RoleBinding
listNamespaced :: Config -> ListNamespacedOptions -> Aff (Either MetaV1.Status RbacV1Alpha1.RoleBindingList)
listNamespaced cfg options = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings" <> Client.formatQueryString options

-- | read the specified RoleBinding
readNamespaced :: Config -> Aff (Either MetaV1.Status RbacV1Alpha1.RoleBinding)
readNamespaced cfg = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings/{name}"

-- | replace the specified RoleBinding
replaceNamespaced :: Config -> RbacV1Alpha1.RoleBinding -> Aff (Either MetaV1.Status RbacV1Alpha1.RoleBinding)
replaceNamespaced cfg body = Client.makeRequest (Client.put cfg url (Just encodedBody))
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/namespaces/{namespace}/rolebindings/{name}"
    encodedBody = encodeJSON body

-- | watch individual changes to a list of RoleBinding
watchListForAllNamespaces :: Config -> Aff (Either MetaV1.Status MetaV1.WatchEvent)
watchListForAllNamespaces cfg = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/watch/rolebindings"

-- | watch changes to an object of kind RoleBinding
watchNamespaced :: Config -> Aff (Either MetaV1.Status MetaV1.WatchEvent)
watchNamespaced cfg = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/watch/namespaces/{namespace}/rolebindings/{name}"

-- | watch individual changes to a list of RoleBinding
watchNamespacedList :: Config -> Aff (Either MetaV1.Status MetaV1.WatchEvent)
watchNamespacedList cfg = Client.makeRequest (Client.get cfg url Nothing)
  where
    url = "/apis/rbac.authorization.k8s.io/v1alpha1/watch/namespaces/{namespace}/rolebindings"