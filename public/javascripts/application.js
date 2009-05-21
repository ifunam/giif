// Usage:
//
// <script type="text/javascript" charset="utf-8">
// //<![CDATA[
// attendeeForm = new Subform('<%= escape_javascript(render(:partial => "attendee", :object => Attendee.new)) %>',<%= @registration.attendees.length %>,'attendees');
// //]]>
// </script>
var Subform = Class.create({
  lineIndex: 1,
  parentElement: "",
 
  // rawHTML contains the html to add using the "add" link
  // lineIndex should be the length of the original array
  // parentElement is the id of the div that the subforms attach to
  initialize: function(rawHTML, lineIndex, parentElement) {
    this.rawHTML = rawHTML;
    this.lineIndex = lineIndex;
    this.parentElement = parentElement;
  },
 
  // parses the rawHTML and replaces all instances of the word
  // INDEX with the line index
  // So the HTML on that rails outputs will be INDEX, but when this
  // is added to the dom it has the correct id
  parsedHTML: function() {
    return this.rawHTML.replace(/INDEX/g, this.lineIndex++);
  },
  
  // handles the inserting of the child form
  add: function() {
    new Insertion.Bottom($(this.parentElement), this.parsedHTML());
  }
});