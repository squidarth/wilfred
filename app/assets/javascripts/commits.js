App = Ember.Application.create();


var sampleObj = {
  commits: [

  {
    email: "hello@hello.com"
  , message: "hello"
  , formatted_sha1: "asdfasdf"
  , verified: false
  , failed: false
  , not_checked: true
  },
  {
    email: "hello@hello.com"
  , message: "hello"
  , formatted_sha1: "asdfasdf"
  , verified: false
  , failed: false
  , not_checked: true

  }
  ]
};

App.Commit = Ember.Object.extend({
    email: null
  , message: null
  , formatted_sha1: null 
  , verified: null
  , failed: null
  , not_checked: null
});

App.IndexRoute =  Ember.Route.extend({
  model: function() {
    var commits = []; 
    $.each(sampleObj.commits, function(index, value) {
      commits.push(App.Commit.create(value));
    });

    return commits;
   }
});

