lbry.lighthouse = {
  // We get the list of search servers from the daemon, but this list is used as a default in case
  // the daemon somehow fails to respond before the first time we query Lighthouse.
  default_servers: [
    'http://lighthouse1.lbry.io:50005',
    'http://lighthouse2.lbry.io:50005',
    'http://lighthouse3.lbry.io:50005',
  ],
  servers: null,
  path: '/',

  call: function(method, params, callback, errorCallback, connectFailedCallback) {
    lbry.jsonrpc_call(this.server + this.path, method, params, callback, errorCallback, connectFailedCallback);
  },
};

lbry.lighthouse.server = lbry.choice(lbry.lighthouse.default_servers);
lbry.getSearchServers(function(servers) {
    lbry.lighthouse.server = lbry.choice(servers);
});