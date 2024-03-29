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
