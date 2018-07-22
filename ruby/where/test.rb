require 'minitest/autorun'

class WhereTest < Minitest::Test
  def setup
    @boris   = {:name => 'Boris The Blade', :quote => "Heavy is good. Heavy is reliable. If it doesn't work you can always hit them.", :title => 'Snatch', :rank => 4}
    @charles = {:name => 'Charles De Mar', :quote => 'Go that way, really fast. If something gets in your way, turn.', :title => 'Better Off Dead', :rank => 3}
    @wolf    = {:name => 'The Wolf', :quote => 'I think fast, I talk fast and I need you guys to act fast if you wanna get out of this', :title => 'Pulp Fiction', :rank => 4}
    @glen    = {:name => 'Glengarry Glen Ross', :quote => "Put. That coffee. Down. Coffee is for closers only.",  :title => "Blake", :rank => 5}

    @fixtures = [@boris, @charles, @wolf, @glen]
  end

  def test_where_with_exact_match
    assert_equal [@wolf], @fixtures.where(:name => 'The Wolf')
  end

  def test_where_with_partial_match
    assert_equal [@charles, @glen], @fixtures.where(:title => /^B.*/)
  end

  def test_where_with_mutliple_exact_results
    assert_equal [@boris, @wolf], @fixtures.where(:rank => 4)
  end

  def test_with_with_multiple_criteria
    assert_equal [@wolf], @fixtures.where(:rank => 4, :quote => /get/)
  end

  def test_with_chain_calls
    assert_equal [@charles], @fixtures.where(:quote => /if/i).where(:rank => 3)
  end
end

class Array
  def where (hash)
    #Get the keys and the values from the hash
    keys = hash.keys
    values = hash.values

    i = 0
    newArray = [] #Create a new array to hold any matching hashes
    while i < self.length
      #Keep track of the conditions that return true
      true_val = 0
      
      #Loop through the current hash to see if the conditions match
      k = 0
      while k < hash.length

        if values[k] === self[i][keys[k]]
          true_val += 1
        end
        
        k += 1
      end

      #If all the conditions are true, add the hash to the new array
      if true_val == hash.length
        newArray.push(self[i])
      end

      i += 1
    end
    newArray
  end
end