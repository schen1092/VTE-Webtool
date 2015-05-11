module ProvidersHelper


	def calculate_provider_cumulative_compliance(prov)
		if prov.orders.length.to_f == 0
			number = 0
			number
		else
			number = (prov.orders.where(MEDICATION_COMPLIANCE: "YES").length)/prov.orders.length.to_f
			number*100
		end
	end

	def calculate_cohort_cumulative_compliance
		# Returns a list of cohort cumulative compliances
		cohort_compliance_list = Array.new

		@providers = Provider.all
		@providers.each do |prov|
			cohort_compliance_list.push([prov, calculate_provider_cumulative_compliance(prov)])
		end

		cohort_compliance_list = cohort_compliance_list.sort  {|a,b| b[1] <=> a[1]} # sorts descending order based on second element in tuple, [provider, COMPLIANCE]

		#calculate ranking
		rank = 0
		previous_compliance = 150 
		tally = 1
		for i in 0...cohort_compliance_list.length
			c = cohort_compliance_list[i]
			if c[1] < previous_compliance
				previous_compliance = c[1]
				rank += tally

				# gather monthly stats for this provider
				m = calculate_provider_monthly_compliance(c[0])

				compliant_orders = c[0].orders.where(MEDICATION_COMPLIANCE: "YES").length
				total_orders = c[0].orders.length


				cohort_compliance_list[i] = [c[0], rank, m[0], m[1], m[2], compliant_orders, total_orders,c[1]]
				tally = 1
			else
				cohort_compliance_list[i] = [c[0], rank, m[0], m[1], m[2], compliant_orders, total_orders,c[1]]
				tally += 1
			end
		end
		cohort_compliance_list #each element [provider, RANKING,monthly compliant orders, monthly total orders, monthly COMPLIANCE, cumulative compliant orders, cumulative total orders, cumulative COMPLIANCE]
	end

	def calculate_provider_ranking(provider)

		cohort_compliance_list = calculate_cohort_cumulative_compliance

		ranking = 0

		for c in cohort_compliance_list
			if c[0].ORDERING_PROVIDER == provider.ORDERING_PROVIDER
				ranking = c[1]
				break
			end
		end

		ranking.to_s + '/' + cohort_compliance_list.length.to_s
	end

	def calculate_provider_monthly_compliance(provider)
		d = Date.today
		d = d - 1.month
		currentMonthOrders = provider.orders.where("strftime('%m', ORD_DT) + 0 = ?", d.month).where("strftime('%Y', ORD_DT) + 0= ?", d.year)
		if currentMonthOrders.length.to_f != 0
			lengthOrdersYes = currentMonthOrders.where(MEDICATION_COMPLIANCE: "YES").length
			lengthOrdersTotal = currentMonthOrders.length
			comp = lengthOrdersYes.to_f/lengthOrdersTotal.to_f
			comp = comp * 100
		else
			comp = 0
		end
		[lengthOrdersYes, lengthOrdersTotal, comp]
	end


	def calculate_provider_monthspan_compliance
		compHash = Hash.new

		d = Date.today

		while d.month != 7 do
			d = d - 1.month

			currentMonthOrders = @provider.orders.where("strftime('%m', ORD_DT) + 0 = ?", d.month).where("strftime('%Y', ORD_DT) + 0= ?", d.year)
			comp = currentMonthOrders.where(MEDICATION_COMPLIANCE: "YES").length/currentMonthOrders.length.to_f
			comp = comp * 100

			compHash[d] = number_to_percentage(comp, precision: 1)

		end
		compHash
	end

	#gonna replace this function with calculate_provider_monthly_compliane
	def get_provider_monthly_stats(provider)
		prevDate = 1.month.ago
		prevMonth = prevDate.month
		prevYear = prevMonth.year
		prevOrders = provider.orders.where("strftime('%m', ORD_DT) + 0 = ?", prevMonth).where("strftime('%Y', ORD_DT) + 0 = ?", prevYear)
		
		monthly_compliance = 0
		if prevOrders.length.to_f != 0
			monthly_compliance = prevOrders.where(MEDICATION_COMPLIANCE: "YES").length/prevOrders.length.to_f * 100
		end

		# return [compliant monthly orders, total monthly orders, monthly compliance]
		[prevOrders.where(MEDICATION_COMPLIANCE: "YES").length, prevOrders.length, monthly_compliance]

	end

	def calculate_cohort_monthspan_compliance
		compHash = Hash.new
		d = Date.today

		while d.month != 7 do
			d = d - 1.month
			comptemp = 0
			monthSumOrder = 0
			@providers = Provider.all
			@providers.each do |prov|
				currentMonthOrders = prov.orders.where("strftime('%m', ORD_DT) + 0 = ?", d.month).where("strftime('%Y', ORD_DT) + 0= ?", d.year)
				comp = currentMonthOrders.where(MEDICATION_COMPLIANCE: "YES").length
				monthSumOrder = monthSumOrder + currentMonthOrders.length
				comptemp = comptemp + comp
			end
			comptemp = comptemp.to_f/monthSumOrder.to_f * 100
			compHash[d] = number_to_percentage(comptemp, precision: 1)
		end
		compHash
	end
end
