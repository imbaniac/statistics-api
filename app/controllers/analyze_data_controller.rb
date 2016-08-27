class AnalyzeDataController < ApplicationController

	include Statistic # ./concerns/statistic.rb

	def statistics
		@result = analyze_data(params[:arr])
		render json: @result
	end

	def correlations
		@corr = correlate(params[:arr1], params[:arr2])
		render json: @corr
	end
end
