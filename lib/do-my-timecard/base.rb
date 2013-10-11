module DoMyTimeCard
  class DoIt
    def perform
      check_vars
      DoMyTimeCard::Login.visit
      login = DoMyTimeCard::Login.new
      login.type_username ENV['TIMECARD_USER']
      login.type_password ENV['TIMECARD_PASS']
      login.log_in

      DoMyTimeCard::Home.new.click_timecards_link

      timecard = DoMyTimeCard::Timecard.new
      timecard.new_timecard

      timecard.timecard_table.rows.first.choose_assignment
      timecard.assignment_lookup.select_my_assignment
      timecard.timecard_table.rows.first.select_sub_project ENV['TIMECARD_SUB_PROJECT']
      timecard.timecard_table.rows.first.select_location ENV['TIMECARD_COUNTRY']

      timecard.timecard_table.rows.first.type_mon ENV['TIMECARD_MON'] unless ENV['TIMECARD_MON'] == '0'
      timecard.timecard_table.rows.first.type_tue ENV['TIMECARD_TUE'] unless ENV['TIMECARD_TUE'] == '0'
      timecard.timecard_table.rows.first.type_wed ENV['TIMECARD_WED'] unless ENV['TIMECARD_WED'] == '0'
      timecard.timecard_table.rows.first.type_thu ENV['TIMECARD_THU'] unless ENV['TIMECARD_THU'] == '0'
      timecard.timecard_table.rows.first.type_fri ENV['TIMECARD_FRI'] unless ENV['TIMECARD_FRI'] == '0'
      timecard.timecard_table.rows.first.type_sat ENV['TIMECARD_SAT'] unless ENV['TIMECARD_SAT'] == '0'
      timecard.timecard_table.rows.first.type_sun ENV['TIMECARD_SUN'] unless ENV['TIMECARD_SUN'] == '0'

      timecard.submit
      timecard.confirm

      timecard.check_result
    end

    def check_vars
      raise "Need a user name" unless ENV['TIMECARD_USER']
      raise "Need a password" unless ENV['TIMECARD_PASS']
      raise "Need a country" unless ENV['TIMECARD_COUNTRY']
      raise "Need a sub project" unless ENV['TIMECARD_SUB_PROJECT']
      raise "Need a value for Monday" unless ENV['TIMECARD_MON']
      raise "Need a value for Tuesday" unless ENV['TIMECARD_TUE']
      raise "Need a value for Wednesday" unless ENV['TIMECARD_WED']
      raise "Need a value for Thursday" unless ENV['TIMECARD_THU']
      raise "Need a value for Friday" unless ENV['TIMECARD_FRI']
      raise "Need a value for Saturday" unless ENV['TIMECARD_SAT']
      raise "Need a value for Sunday" unless ENV['TIMECARD_SUN']
    end
  end
end

module DoMyTimeCard
  class Login < CapybaraPageObject::Page

    path ""

    def type_username(input)
      source.fill_in("username", with: input)
    end

    def type_password(input)
      source.fill_in("password", with: input)
    end

    def log_in
      source.find(:css, "input.btn-submit[value='LOGIN']").click
    end
  end
end

module DoMyTimeCard
  class Home < CapybaraPageObject::Page
    def click_timecards_link
      source.click_link("Timecards")
    end
  end
end

module DoMyTimeCard
  class Timecard < CapybaraPageObject::Page
    def new_timecard
      source.find("input.btn[title='New']").click
    end

    def timecard_table
      DoMyTimeCard::TimecardTable.new source.find("#timecardTable")
    end

    def assignment_lookup
      DoMyTimeCard::AssignmentLookup.new source.find(".yui-widget-bd")
    end

    def submit
      source.all("input#submitTCButton[value='Submit']").first.click
    end

    def confirm
      source.driver.browser.switch_to.alert.accept
    end

    def check_result
      msg = source.has_content?("Timecards submitted for approval") ? "Timecards submitted for approval" : "some thing went wrong, please check!"
      STDOUT.puts msg
    end
  end
end

module DoMyTimeCard
  class TimecardTable < CapybaraPageObject::Component
    def rows
      source.all("#editDetailRowParentTbody tr.dataRow").map {|row| DoMyTimeCard::Row.new row }
    end
  end
end

module DoMyTimeCard
  class Row < CapybaraPageObject::Element
    def choose_assignment
      source.find(".lookupIcon[title='Choose Assignment']").click
    end

    def select_sub_project(option)
      source.find(:xpath, "//option[text()='#{option}']").click
    end

    def select_location(option)
      source.find("option[value='#{option}']").click
    end

    def type_mon(text)
      source.all("input.hrInputText")[0].set text
    end

    def type_tue(text)
      source.all("input.hrInputText")[1].set text
    end

    def type_wed(text)
      source.all("input.hrInputText")[2].set text
    end

    def type_thu(text)
      source.all("input.hrInputText")[3].set text
    end

    def type_fri(text)
      source.all("input.hrInputText")[4].set text
    end

    def type_sat(text)
      source.all("input.hrInputText")[5].set text
    end

    def type_sun(text)
      source.all("input.hrInputText")[6].set text
    end
  end
end

module DoMyTimeCard
  class AssignmentLookup < CapybaraPageObject::Component
    def select_my_assignment
      source.find("a[href='#'][onclick]").click
    end
  end
end
