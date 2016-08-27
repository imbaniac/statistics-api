This the API for RailsReactor test assignment

What works:
+ Full statistic analysis (min, max, average, median, quartiles and outliers)
+ Ability to correlate two sequences of numbers (using Pearson product-moment correlation coefficient)
+ User authentication (Devise auth token)
+ Basic integration tests

For now API is accessible only with authentication token, that is created with a new User.

###Sign_up - users#create
```
curl -X POST -H "Content-Type: application/json" -d '{"user": {"username": "testuser", "email": "test@example.com", "password": "12341234", "password_confirmation": "12341234"}}' http://localhost:3000/users
>> {"email":"test@example.com","username":"testuser","token_type":"Bearer","user_id":12,"access_token":"12:cccyXLZ7o_XpK6MxU_Bt"}
```

###Log_in - sessions#create
```
curl -X POST -H "Content-Type: application/json" -d '{"email": "test@example.com", "password": "12341234"}' http://localhost:3000/login
>> {"email":"test@example.com","username":"testuser","token_type":"Bearer","user_id":12,"access_token":"12:cccyXLZ7o_XpK6MxU_Bt"}
```

###Statistics - analyze_data#statistics
```
curl -X GET -H "Content-type: application/json" -H "Authorization: auth_token" http://localhost:3000/statistics/?arr=1,2,3,4
```

###Correlations - analyze_data#correlations
```
curl -X GET -H "Content-type: application/json" -H "Authorization: auth_token" http://localhost:3000/correlations/?arr1=1,2,3,4&arr2=1,2,3,6
```

To work with statistics API you should add to your GET request parameter arr with sequence of numbers. IE `?arr=1,2,3,4`
To work with correlation API you should add to your GET request parameters arr1 and arr2 with sequences of numbers. IE `?arr1=1,2,3,4&arr2=1,5,6,2`
