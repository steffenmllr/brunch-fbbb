// Create `window.describe` etc. for our BDD-like tests.
mocha.setup({
    ui: 'bdd'
});

// Create another global variable for simpler syntax.
window.expect = chai.expect;
window.should = chai.should();
window.sinon = sinon;

// Mock Facebook API
window.FB = {
    api: function() {},
    Events: {
        subscribe: function() {}
    },
    login: function() {}
};

// Overwrite Config
require.define({
    "config": function(exports, require, module) {
        module.exports = {
            language: 'de_DE',
            appID: '436453793083114',
            appSecret: '3aa3ecb059ccd8a7baf7851e943e1c35',
            scope: ['email', 'publish_stream'],
            public_config: {
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
    }
});