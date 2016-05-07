require 'date'

# The following Ruby hash provides the following information about a property:

# availability of the property by day (N means unavailable, Y means available)
# the property's minimum stay requirement by day (i.e., for at least how many nights the property must be booked if the stay begins on that day)
# the nightly rate of the property by day

# The data is from the start date, inclusive (so 2015-01-01 is unavailable, has a minimum stay of 6 days, and costs $248)

property = {
  start_date: "2015-01-01",
  availability: "NNNNYYNNNNNNNNNNYYYYYNNNNNNNNYYYNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNYYYYYYYYYNNNNYYYYYYYYNNNNNNNNNNYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY",
  minstay:
"6,5,3,6,6,6,4,6,3,3,6,5,3,3,5,6,6,4,5,2,2,6,3,5,4,6,2,6,6,5,2,4,2,2,4,3,2,5,3,4,2,2,5,4,2,6,3,3,3,3,5,6,5,3,6,4,2,3,2,3,2,4,2,2,6,3,6,4,3,5,4,3,3,2,5,3,4,3,4,6,6,4,4,5,2,3,6,3,5,2,2,4,6,5,5,2,6,6,3,6,2,3,3,6,3,2,3,4,4,4,5,2,2,5,2,3,3,6,5,3,3,3,5,2,4,2,6,5,4,4,3,4,3,3,6,5,5,4,3,3,2,4,6,3,3,6,6,4,2,2,3,4,2,6,5,2,6,3,2,4,3,4,5,6,5,3,6,5,6,2,4,3,4,2,3,5,6,3,2,2,2,6,6,2,5,2,3,2,4,4,4,6,6,4,3,2,4,5,5,2,3,2,4,6,6,5,6,2,6,3,2,6,2,6,2,5,5,5,5,4,2,6,3,2,2,2,6,6,5,5,4,4,5,4,2,2,5,5,5,2,6,4,4,4,3,2,6,3,3,2,4,2,6,6,3,6,4,5,4,4,5,6,6,6,6,3,3,5,5,6,3,5,5,6,6,3,2,4,2,3,5,3,4,3,3,3,3,4,5,2,6,5,6,5,5,4,2,3,3,2,4,6,3,2,3,2,3,3,4,5,3,3,6,5,2,6,4,5,5,6,2,4,6,5,2,5,3,4,6,3,3,3,4,5,4,4,4,5,4,3,6,2,2,2,6,4,2,2,6,4,5,3,3,4,2,5,6,5,6,5,3,5,2,2,5",
  price:
"248,109,138,227,104,207,163,119,249,261,162,286,235,205,210,215,259,227,203,183,181,153,140,258,103,198,253,286,254,133,202,142,163,261,205,133,113,152,130,193,153,140,174,282,128,268,114,199,168,254,296,267,224,249,200,207,160,124,108,165,259,293,143,282,267,129,114,268,249,186,255,124,161,247,297,100,113,170,201,239,283,180,142,220,105,294,226,228,101,108,104,187,238,251,106,259,262,120,174,141,231,207,270,193,292,121,250,166,171,287,220,142,176,195,180,215,155,243,116,249,265,164,172,213,151,132,215,235,116,181,260,199,203,189,251,124,128,152,128,188,140,273,176,208,143,143,108,265,269,273,265,182,275,237,188,183,108,234,137,270,106,273,122,105,171,236,213,278,281,102,117,163,277,104,294,252,210,124,203,253,100,220,205,226,100,236,101,150,148,104,205,110,249,175,131,185,210,262,290,271,214,247,158,210,220,156,137,284,245,212,137,237,235,112,158,278,127,132,272,104,103,274,199,260,154,209,186,260,251,247,180,106,107,102,164,290,166,243,234,244,108,182,249,118,99,131,191,231,247,152,120,146,154,223,209,111,116,194,101,212,163,110,257,196,230,250,273,152,116,185,158,276,293,285,219,101,119,159,170,168,147,104,211,137,235,136,136,152,281,176,134,144,130,298,269,272,101,168,141,198,184,154,186,109,230,185,195,282,265,210,290,265,194,120,122,240,256,280,289,164,109,136,213,267,161,265,162,162,182,196,251,204,191,280,199,243,214,255,180,183,200,114,250,159,267,217,213,263,151,115,223,221,244,261,190,166,112,266,291,283,249,135,102,151,113"
}


# Write a function that accepts the above object as an argument, and returns an array of all
# available contiguous date ranges, listing only the start and end dates of each range (of the format [[start_date, end_date], [start_date, end_date]]).

def available_ranges(property)
    
    # Turn availability into array of characters
    availability = property[:availability].chars.to_a
    
    # Turn minstay into array by splitting on ','
    minstay =  property[:minstay].split(",")

    # DEBUG start with smaller array
    n = 75
    availability = availability[0..n]
    minstay = minstay[0..n]

    # Counting variables to keep track of possible date ranges
    start_date_obj = Date.parse(property[:start_date])
    start_index = 0
    min_days = 0

    # Initialize output array
    available_dates = []

    # Iterate through availability by creating a range of 0 to length of availability array
    for i in (0..availability.length)
        # If avaiablity is Y, possible start_index = i
        if availability[i] === "Y"
            start_index = i

            # get the min stay length for starting on that day
            min_days = minstay[i].to_i

            # Iterate through availability starting after start index
            for j in(i..availability.length)
                # If not available, break out of loop
                break if availability[j] === "N"

                # If available and if this is at least min_days from start index, including the first day, add it to output
                if j+1-i >= min_days
                    # We have a winner! Format into date strings to add to output array
                    start_day_to_add = (start_date_obj + i).strftime('%F')
                    end_day_to_add = (start_date_obj + j).strftime('%F')

                    puts "Start index: \t #{start_index}"
                    puts "Start day: \t #{start_day_to_add}"
                    puts "End day: \t #{end_day_to_add}"
                    # Add this to output
                    available_dates.push([start_day_to_add,end_day_to_add])
                else
                    # keep going
                    next
                end
            end
        end

    end

    puts "available dates: \n #{available_dates}"
    # print available_dates
    # print available_dates

    return available_dates

end


# Write a function that, given a start date and end date, returns the total cost of booking the property for that date range, or zero if the property is unavailable for any date in the range.


def cost_of_booking(property, start_date, end_date)
    # Turn availability into array of characters
    availability = property[:availability].chars.to_a
  
    # Turn price into array
    price = property[:price].split(",")

    # Turn start_date to a date object
    start_date_obj = Date.parse(start_date)

    # Turn end_Date to date object
    end_date_obj = Date.parse(end_date)

    # Turn the property object start date into date object
    prop_start_date_obj = Date.parse(property[:start_date])

    # The difference between the input start date and the property object start date is the start index
    start_index = (start_date_obj - prop_start_date_obj).to_i

    # The end index is the difference between the end_date and the 
    end_index = (end_date_obj - prop_start_date_obj).to_i

    # Initialize total cost to return
    total_cost = 0

    (start_index..end_index).each do |i|
        # First check availability, and break out of loop 
        if availability[i] === "N"
            total_cost = 0
            break
        else
            total_cost += price[i].to_i
        end
    end

    print "Total cost #{total_cost}"
    return total_cost
  
    # TODO: handle if given end date is before start date
    # TODO: handle if start_date or end_date aren't in property's range
    # TODO: handle if end_date - start_date is less than the given minstay for the start_date

end



# Test
available_ranges(property)

cost_of_booking(property, '2015-01-18', '2015-01-21')
cost_of_booking(property, '2015-01-21', '2015-01-23')
