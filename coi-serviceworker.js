// coi-serviceworker v0.1.7 - Guido Zufolo (MIT License)
if (typeof window === 'undefined') {
  self.addEventListener('install', () => self.skipWaiting());
  self.addEventListener('activate', (event) => event.waitUntil(self.clients.claim()));

  self.addEventListener('fetch', (event) => {
    if (event.request.cache === 'only-if-cached' && event.request.mode !== 'same-origin') {
      return;
    }

    event.respondWith(
      fetch(event.request)
        .then((response) => {
          if (response.status === 0) {
            return response;
          }

          const newHeaders = new Headers(response.headers);
          newHeaders.set('Cross-Origin-Embedder-Policy', 'require-corp');
          newHeaders.set('Cross-Origin-Opener-Policy', 'same-origin');

          return new Response(response.body, {
            status: response.status,
            statusText: response.statusText,
            headers: newHeaders,
          });
        })
        .catch((e) => console.error(e))
    );
  });
} else {
  (() => {
    const script = document.currentScript;
    const coi = {
      shouldRegister: () => true,
      shouldDeregister: () => false,
      doCoep: () => true,
      doCoop: () => true,
      quiet: false,
      ...script?.dataset,
    };

    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.controller?.postMessage({ type: 'coi-ping' });

      navigator.serviceWorker.register(window.location.href).then(
        (registration) => {
          if (!coi.quiet) console.log('COI Service Worker registered');

          registration.addEventListener('updatefound', () => {
            const worker = registration.installing;
            worker.addEventListener('statechange', () => {
              if (worker.state === 'installed' && navigator.serviceWorker.controller) {
                if (!coi.quiet) console.log('COI Service Worker updated; reloading page...');
                window.location.reload();
              }
            });
          });
        },
        (err) => {
          if (!coi.quiet) console.error('COI Service Worker failed to register:', err);
        }
      );
    }
  })();
}
