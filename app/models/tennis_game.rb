class TennisGame < ActiveRecord::Base


	def initialize(player_one, player_two)
		@player_one = player_one
		@player_two = player_two
		@p1_points = 0
		@p2_points = 0
	end


	TENNIS_SCORE_MAP = {
		0 => "love",
		1 => "15",
		2 => "30",
		3 => "40",
	}

	def translate(score)
		TENNIS_SCORE_MAP[score]
	end

	def won_point(playerName)
		if playerName == @player_one
			@p1_points += 1
		elsif playerName == @player_two
			@p2_points += 1
		else
				@p2_points = 100
		end
	end


	def score
		p1_tenScore = translate(@p1_points)
		p2_tenScore = translate(@p2_points)
		
		if (@p1_points < 3 && @p2_points < 3)
			score_before_deuce_or_defeat(p1_tenScore, p2_tenScore)
		elsif ((@p1_points - @p2_points) == 1 && @p1_points > 3) || ((@p2_points - @p1_points) == 1 && @p2_points > 3)
			score_after_deuce(@p1_points, @p2_points)
		elsif (@p1_points == @p2_points && @p1_points >= 3)
			"Deuce"
		elsif (@p1_points >= 4 || @p2_points >= 4)
			score_after_victory(@p1_points, @p2_points)
		elsif ((@p1_points == 3 || @p2_points == 3) && @p1_points != @p2_points)
			score_before_deuce_or_defeat(p1_tenScore, p2_tenScore)
		end
	end

	def score_before_deuce_or_defeat(p1_tenScore, p2_tenScore)
		"#{p1_tenScore}-#{p2_tenScore}"
	end

	def score_after_deuce(p1_score, p2_score)
		if (p1_score.to_i > p2_score.to_i)
			"Advantage In"
		else
			"Advantage Out"
		end
	end

	def score_after_victory(p1_score, p2_score)
		if (p1_score > p2_score)
			"#{@player_one} defeats #{@player_two}"
		else
			"#{@player_two} defeats #{@player_one}"
		end
	end

	def score_one_player_40
	end


end
