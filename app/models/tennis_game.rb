class TennisGame < ActiveRecord::Base


	def initialize(player_one, player_two)
		@player_one = player_one
		@player_two = player_two
		@p1_points = 0
		@p2_points = 0
	end



	def translate(score)
		if score == 0
			"love"
		elsif score == 1
			"15"
		elsif score == 2
			"30"
		elsif score == 3
			"40"
		else
			score
		end
	end

	def won_point(playerName)
		if playerName == @player_one
			@p1_points +=1
		elsif playerName == @player_two
			@p2_points +=1
		else
				@p2_points = 100
		end
	end


	def score
		p1_tenScore = translate(@p1_points)
		p2_tenScore = translate(@p2_points)
		if (@p1_points < 3 && @p2_points < 3)
			"#{p1_tenScore}-#{p2_tenScore}"
		elsif ((@p1_points - @p2_points)==1 && @p1_points > 3)
			"Advantage In"
		elsif ((@p2_points - @p1_points)==1 && @p2_points > 3)
			"Advantage Out"
		elsif (@p1_points == @p2_points && @p1_points >= 3)
			"Deuce"
		elsif (@p1_points >= 4)
			"#{@player_one} defeats #{@player_two}"
		elsif (@p2_points >= 4)
			"#{@player_two} defeats #{@player_one}"
		elsif ((@p1_points == 3 || @p2_points == 3) && @p1_points != @p2_points)
			"#{p1_tenScore}-#{p2_tenScore}"
		end
	end


end
