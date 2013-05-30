module.exports = {
  index: function(){
    this.visits = (this.visits || 0) + 1;

    this.response.writeHead(200, {"Content-Type": "text/plain"});
    this.response.write("You are in home/index!");
    this.response.write("\nThis home page has been visited " + this.visits + " times!");
    this.response.end();
  }
};
