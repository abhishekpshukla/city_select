require File.dirname(__FILE__) + '/spec_helper'

 describe "A user selects the andra pradesh" do  
   it "should display the list of citis from andra pradesh"  do
	 #body['#user_city'] = "test"
	 response.should_not have_text("City")
   end
 end  
