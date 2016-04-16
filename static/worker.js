// Settings
const cacheName =
  'v1/shell';

const indexHtmlLocation =
  '/index.html';

const appShellResources = [
  '/scripts.js',
  '/fonts/merriweather-light.woff',
  '/fonts/merriweather-light-italic.woff',
];

const fetchStrategies = [{
  name: 'get index.html',
  pattern:
    /^(?:\/[^.]*)?$/,
}, {
  name: 'prefer cache',
  pattern: new RegExp([
    '\.html$',
    '\.ico$',
    '\.css$',
    '^/scripts\.js$',
  ].join('|')),
}, {
  name: 'prefer network',
  pattern: new RegExp([
    '^/api/.*\.json$',
  ].join('|')),
}];


// Pre-fetch app shell.
const indexHtmlRequest =
  new Request(indexHtmlLocation);

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(cacheName)
      .then((cache) => {
        cache.add(indexHtmlRequest);
        cache.addAll(appShellResources);
      })
  );
});


// Handle requests.
const fetchFromCache = (request) => () => (
  caches.match(request).then((response) => {
    if (response === undefined) {
      throw new Error(`Nothing found in the cache for ${request.url}`);
    }

    return response;
  })
);

const putInCache = (request) => (response) => {
  if (response.ok) {
    const responseCopy = response.clone();
    caches.open(cacheName)
      .then(cache => cache.put(request, responseCopy));
  }

  return response;
};

let looksLikeWereOffline =
  false;

const rememberToUpdateCache = (request) => (cachedResponse) => {
  // Schedule cache update
  if (!looksLikeWereOffline) {
    fetch(request)
      .then(putInCache(request))
      .catch(() => { looksLikeWereOffline = true; });
  }

  return cachedResponse;
};

const fetchNetworkFirst = (request) => () => (
  fetch(request)
    .then(putInCache(request))
    .catch(fetchFromCache(request))
);

const respondCacheFirst = (event, request) => {
  event.respondWith(
    fetchFromCache(request)()
      .then(rememberToUpdateCache(request))
      .catch(fetchNetworkFirst(request))
  );
};

self.addEventListener('fetch', (event) => {
  const request = event.request;
  const url = new URL(request.url);
  const fetchStrategy = fetchStrategies.find(strategy => (
    strategy.pattern.test(url.pathname)
  ));

  const criteria = [
    request.method === 'GET',
    url.origin === self.location.origin,
    fetchStrategy !== undefined,
  ];

  if (!criteria.every(passed => passed)) return;

  if (fetchStrategy.name === 'get index.html') {
    respondCacheFirst(event, indexHtmlRequest);
  } else if (fetchStrategy.name === 'prefer cache') {
    respondCacheFirst(event, request);
  } else if (fetchStrategy.name === 'prefer network') {
    event.respondWith(fetchNetworkFirst(request)());
  }
});
