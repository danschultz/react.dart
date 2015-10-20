var ClickCounter = React.createClass({
  getInitialState: function() {
    return {count: 0};
  },

  render: function() {
    return React.DOM.button({}, "Count: " + this.state.count);
  }
});
