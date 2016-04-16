const cacheName = 'v1/shell';

const alwaysFetchThese = [
  '/',
  '/scripts.js',
  '/fonts/merriweather-light.woff',
  '/fonts/merriweather-light-italic.woff',
];

const preferCache = new RegExp([
  '\.html$',
  '\.ico$',
  '\.css$',
  '^/scripts\.js$',
].join('|'));

const preferNetwork = new RegExp([
  '^/api/.*\.json$',
].join('|'));


// Pre-fetch app shell.
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(cacheName)
      .then((cache) => (
        cache.addAll(alwaysFetchThese)
      ))
  );
});


// Handle requests.
self.addEventListener('fetch', (event) => {
  const request = event.request;
  const url = new URL(request.url);
  const fetchStrategy = (
    (preferCache.test(url.pathname) && 'cache first') ||
    (preferNetwork.test(url.pathname) && 'network first') ||
    null
  );

  const criteria = [
    request.method === 'GET',
    url.origin === self.location.origin,
    fetchStrategy !== null,
  ];

  if (!criteria.every(passed => passed)) return;

  const putInCache = (response) => {
    if (response.ok) {
      const responseCopy = response.clone();
      caches.open(cacheName)
        .then(cache => cache.put(request, responseCopy));
    }

    return response;
  };

  const fetchFromCache = () => (
    caches.match(request).then((response) => {
      if (response === undefined) {
        throw new Error(`Nothing found in the cache for ${request.url}`);
      }

      return response;
    })
  );

  const fetchNetworkFirst = () => (
    fetch(request)
      .then(putInCache)
      .catch(fetchFromCache)
  );

  const rememberToUpdateCache = (cachedResponse) => {
    // Schedule cache update
    fetch(request).then(putInCache);

    return cachedResponse;
  };

  if (fetchStrategy === 'network first') {
    event.respondWith(fetchNetworkFirst());
  } else if (fetchStrategy === 'cache first') {
    event.respondWith(
      fetchFromCache()
        .then(rememberToUpdateCache)
        .catch(fetchNetworkFirst)
    );
  }
});
