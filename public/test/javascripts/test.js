(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    definition(module.exports, localRequire(name), module);
    var exports = cache[name] = module.exports;
    return exports;
  };

  var require = function(name) {
    var path = expand(name, '.');

    if (has(cache, path)) return cache[path];
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex];
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  }

  globals.require = require;
  globals.require.define = define;
  globals.require.brunch = true;
})();

window.require.define({"test/mocks/mock_config": function(exports, require, module) {
  
  module.exports = {
    language: 'de_DE',
    appID: '436453793083114',
    appSecret: '3aa3ecb059ccd8a7baf7851e943e1c35',
    public_config: {
      scope: ['email', 'publish_stream'],
      share: {
        method: "feed",
        redirect_uri: "YOUR URL HERE",
        link: "https://developers.facebook.com/docs/reference/dialogs/",
        picture: "http://fbrell.com/f8.jpg",
        name: "Facebook Dialogs",
        caption: "Reference Documentation",
        description: "Using Dialogs to interact with users."
      }
    }
  };
  
}});

window.require.define({"test/models/facebook_model_test": function(exports, require, module) {
  var FacebookModel;

  FacebookModel = require('models/facebook_model');

  window.FB = {
    api: function() {},
    Events: {
      subscribe: function() {}
    },
    login: function() {}
  };

  describe('Facebook User Model', function() {
    var _this = this;
    before(function() {
      return sinon.stub(window.FB.Events, 'subscribe');
    });
    beforeEach(function() {
      return this.model = new FacebookModel();
    });
    it("should exist", function() {
      return expect(this.model).to.be.ok;
    });
    return describe('Facebook Login Method', function() {
      before(function() {
        return this.fbLogin = sinon.stub(window.FB, 'login');
      });
      it("login should be a function", function() {
        return expect(this.model.login).to.be.a('function');
      });
      return it("FB login can have a callback function", function() {
        var callback;
        callback = sinon.spy();
        this.model.login(callback);
        return this.fbLogin.should.have.been.calledWith(callback);
      });
    });
  });
  
}});

window.require.define({"test/spec": function(exports, require, module) {
  

  
}});

window.require.define({"test/test-helpers": function(exports, require, module) {
  var MockConfig, chai, expect, sinon, sinonChai;

  MockConfig = require('./mocks/mock_config');

  expect = require('expect.js');

  chai = require('chai');

  sinon = require('sinon');

  sinonChai = require("sinon-chai");

  chai.use(sinonChai);

  module.exports = {
    expect: require('chai').expect,
    should: chai.should(),
    sinon: sinon,
    config: MockConfig
  };
  
}});

window.require.define({"test/views/app_view_test": function(exports, require, module) {
  var AppView;

  AppView = require('views/app_view');

  describe('AppView', function() {
    return beforeEach(function() {
      return this.view = new AppView();
    });
  });
  
}});

var hasFilterer = window.brunch && window.brunch.test && window.brunch.test.filterer;
var valid = hasFilterer ? window.brunch.test.filterer('test/models/facebook_model_test') : true;
if (valid) window.require('test/models/facebook_model_test');
var hasFilterer = window.brunch && window.brunch.test && window.brunch.test.filterer;
var valid = hasFilterer ? window.brunch.test.filterer('test/views/app_view_test') : true;
if (valid) window.require('test/views/app_view_test');
