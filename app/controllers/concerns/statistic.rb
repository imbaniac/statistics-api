module Statistic

	def analyze_data(data)
		result = {
			from: data,
			to: {}
		}
		if data.size < 2
			result[:to] = 0
			return result
		end
		data_set = data.split(",").map(&:strip).map(&:to_f)
		result[:to][:max] = data_set.max
		result[:to][:min] = data_set.min
		result[:to][:avg] = avg(data_set)
		result[:to][:median] = quartile(data_set, 2)
		result[:to][:q1] = quartile(data_set, 1)
		result[:to][:q3] = quartile(data_set, 3)
		result[:to][:outliers] = outliers(data_set)
		result
	end

	def avg(array)
		array.reduce(:+) / array.size
	end

	def quartile(array, n)
		sorted = array.sort
		size = sorted.size
		median = (sorted[(size - 1) / 2] + sorted[size / 2]) * 0.5
		if n == 2
			median
		elsif n == 1
			low_part = sorted.select {|el| el < median}
			low_part[low_part.size/2]
		elsif n == 3
			up_part = sorted.select {|el| el > median}
			up_part[up_part.size/2]
		end
	end

	def outliers(array)
		sorted = array.sort
		q1 = quartile(sorted, 1)
		q3 = quartile(sorted, 3)
		k = 1.5
		low = q1-k*(q3-q1)
		up = q3+k*(q3-q1)
		sorted.select {|el| el > up || el < low}
	end

	def correlate(arr1, arr2)
		result = {
			from: [arr1, arr2],
			to: 0
		}
		x = arr1.split(",").map(&:strip).map(&:to_f)
		y = arr2.split(",").map(&:strip).map(&:to_f)

		return result if x.size != y.size

		n = x.size

		sumX = x.reduce(&:+)
		sumY = y.reduce(&:+)

		sumXSq = x.map{|el| el**2}.reduce(&:+)
		sumYSq = y.map{|el| el**2}.reduce(&:+)

		prods = [];
		x.each_with_index{|this_x,i| prods << this_x*y[i]}

		pSum = prods.reduce(&:+)

		num = pSum - (sumX * sumY/n)
		den = ((sumXSq - (sumX**2)/n)*(sumYSq - (sumY**2)/n))**0.5

		0 if den==0

		result[:to] = num/den
		result
	end

end
