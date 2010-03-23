# CitySelect
include CitiesName

module ActionView
	module Helpers
		module FormOptionsHelper
		
			def city_select(object, method, selected_city='Maharashtra', options = {}, html_options = {})
				selected_city = selected_city.gsub(" ","_").upcase
				InstanceTag.new(object, method, self, options.delete(:object)).to_city_select_tag(selected_city, options, html_options)
			end
			
			def city_options_for_select(selected = nil, selected_city = {})
				state_options = ""
				selected_city[:show] = :full if selected_city[:with_abbreviation]
				states_label = case selected_city[:show]
          when :full then lambda { |state| ["#{state.last} - #{state.first}", state.last] }
          when :abbreviations then lambda { |state| [state.last, state.last] }
          else lambda { |state| state }
					end
					
					begin
          if selected_city[:include_blank]
            state_options += "<option value=\"\">--</option>\n"
					end
					
          if selected
            state_options += options_for_select(eval(selected_city).collect(&states_label), selected)
					else
						state_options += options_for_select(eval(selected_city).collect(&states_label), selected)
					end
					return state_options
					rescue Exception => exc
					# handle the exception the way you wants...
					puts "ERROR----------- #{exc.message}"
				end
			end
		end	
		
		class InstanceTag
			
			def to_city_select_tag(selected_city, options, html_options)
				html_options = html_options.stringify_keys
				add_default_name_and_id(html_options)
				content_tag("select", add_options(city_options_for_select(value(object), selected_city), options, value(object)), html_options)
			end
		end
		
		
		class FormBuilder
			
			def city_select(method, selected_city="",  options = {}, html_options = {})
				@template.city_select(@object_name, method, selected_city, options.merge(:object => @object), html_options)
			end
		end
	end
end
