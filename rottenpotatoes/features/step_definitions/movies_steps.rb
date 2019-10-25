Given /the following movies exist/ do |movies_table|
    movies_table.hashes.each do |movie|
        Movie.create!(movie)
    end 
end

Then /^the director of "(.*)" should be "(.*)"$/ do |title_value,director_value|
    movie = Movie.find_by_title(title_value)
    expect(movie.director).to eq director_value
end 


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    main = page.body
    loc_e1 = main.index(e1)
    loc_e2 = main.index(e2)
    
    if loc_e1 == nil || loc_e2 == nil
        fail "One of both search parameters not found"
    else
        expect(loc_e1<loc_e2).to eq true
    end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck,rating_list|
    rating_list.split(",").each do |rating|
        if uncheck
            step "I uncheck \"ratings_#{rating.strip}\""
        else
            step "I check \"ratings_#{rating.strip}\""
        end
    end 
    
end    

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /^the director of "(.*)" should be "(.*)"$/ do |title_value, director_value|
  movie = Movie.find_by_title(title_value)
  expect(movie.director).to eq(director_value)
end