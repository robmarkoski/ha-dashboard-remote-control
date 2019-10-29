document.addEventListener("keyup", function(event) {
    event.preventDefault();
    if (event.keyCode === 13) {
      document.activeElement.click();
      //console.log("Enter!")
    }
  });
  
  $(document).ready(function() {
    // Find all switches. Mostly Spans with a class .toggle-area
    var switchList = $(".toggle-area");
    //set tab index to starts from 1
    tabindex = 0;
    //console.log(tabindex);
  
    switchList.each(function() {
      // add tab index number to each list items
      tabindex++;
      $(this).attr("tabindex", tabindex);
      // Set Tab Index
      var tabIndex = $(this).attr("tabindex");
    });
  });
  
  