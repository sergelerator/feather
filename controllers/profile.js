module.exports = {
  index: function(request, response){
    this.visits = (this.visits || 0) + 1;

    this.response.writeHead(200, {"Content-Type": "text/plain"});
    this.response.write("You are in profile/index!");
    this.response.write("\nThis profile has been visited " + this.visits + " times!");
    this.response.end();
  }
};
