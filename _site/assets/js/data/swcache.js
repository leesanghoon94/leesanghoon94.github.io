const resource = [
  /* --- CSS --- */
  '/assets/css/jekyll-theme-chirpy.css',

  /* --- PWA --- */
  '/app.js',
  '/sw.js',

  /* --- HTML --- */
  '/index.html',
  '/404.html',

  
    '/categories/',
  
    '/tags/',
  
    '/archives/',
  
    '/about/',
  

  /* --- Favicons & compressed JS --- */
  
  
    '/assets/img/favicons/favicon-16x16.png',
    '/assets/img/favicons/favicon-32x32.png',
    '/assets/img/favicons/favicon-96x96.png',
    '/assets/img/favicons/favicon.ico',
    '/assets/img/favicons/favicon1-32x32.png',
    '/assets/img/favicons/favicon1.ico',
    '/assets/img/favicons/safari-pinned-tab.svg',
    '/assets/js/dist/categories.min.js',
    '/assets/js/dist/commons.min.js',
    '/assets/js/dist/home.min.js',
    '/assets/js/dist/misc.min.js',
    '/assets/js/dist/page.min.js',
    '/assets/js/dist/post.min.js'
];

/* The request url with below domain will be cached */
const allowedDomains = [
  
    'www.googletagmanager.com',
    'www.google-analytics.com',
  

  'localhost:4000',

  

  'fonts.gstatic.com',
  'fonts.googleapis.com',
  'cdn.jsdelivr.net',
  'polyfill.io'
];

/* Requests that include the following path will be banned */
const denyUrls = [];

