require 'rails_helper'

RSpec.describe "Data", :type => :request do
	before :each do
		@ok_seq = "1,2,3,54,2,44,4,5,3,4,2"
		@sec_seq = "1,2,3,33,2,54,4,5,3,1,2"
		@short_seq = "1,2,3,33,2,54"
	end

	describe "GET /statistics" do
		it "returns right results with params" do
			get "/statistics?arr=#{@ok_seq}"
			expect(response.status).to eq 200
			results = JSON.parse(response.body)["to"]
			expect(results["min"]).to eq(1.0)
			expect(results["max"]).to eq(54.0)
			expect(results["avg"]).to eq(11.272727272727273)
			expect(results["median"]).to eq(3.0)
			expect(results["q1"]).to eq(2.0)
			expect(results["q3"]).to eq(5.0)
			expect(results["outliers"]).to match_array([44, 54])
		end
	end

	describe "GET /correlations" do
		it "returns 1 with equal arrays" do
			get "/correlations?arr1=#{@ok_seq}&arr2=#{@ok_seq}"
			expect(response.status).to eq 200
			results = JSON.parse(response.body)["to"]
			expect(results).to eq 1
		end

		it "returns 0 when arrays have different length" do
			get "/correlations?arr1=#{@ok_seq}&arr2=#{@short_seq}"
			expect(response.status).to eq 200
			results = JSON.parse(response.body)["to"]
			expect(results).to eq 0
		end

		it "return right result with two arrays" do
			get "/correlations?arr1=#{@ok_seq}&arr2=#{@sec_seq}"
			expect(response.status).to eq 200
			results = JSON.parse(response.body)["to"]
			expect(results).to eq 0.9218367644281574
		end
	end
end
