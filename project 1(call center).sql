select* from call_center;
desc call_center; /*gives information about the data*/

/*count the no of rows, 32941*/
select count(*) from call_center;

/*count the no of columns, 12*/
select count(*) from information_schema.columns where table_name = 'call_center';

/*UNIVARIATE ANALYSIS*/

/*sentiment*/
select count(sentiment) from call_center;          /*no missing values, 32941*/
select distinct(sentiment) from call_center;       /*5 types- Neutral,Very Positive, Negative, Very Negative, Positive*/
select count(distinct(sentiment)) from call_center;
select sentiment, count(sentiment) from call_center group by sentiment; /*Neutral-8754, Very Positive-3170, Negative-11063, Very Negative-6026, Positive-3928*/

/*csat_score*/
update call_center set csat_score = NULL where csat_score = 0;
select* from call_center;
select count(csat_score) from call_center;                  /*12271 non-null values*/
select count(*) from call_center where csat_score is null;  /* 20670 null values */
select distinct(csat_score) from call_center;               /* 10 unique values from 1 to 10 */
select csat_score, count(csat_score) from call_center group by csat_score; /*568 people gives the csat_score as 10 and 595 gives as 1 but max no of people gives csat_score as 5*/

/*call_timestamp*/
update call_center set call_timestamp = str_to_date(call_timestamp,"%m/%d/%Y"); /*updated from text to date time*/
select min(call_timestamp), max(call_timestamp) from call_center;         /*we have the data of complete 1 month i.e. from 2020-10-01 to 2020-10-31*/

/*reason*/
select count(reason) from call_center; /*no null values 32941*/
select distinct(reason) from call_center; /* 3 reasons- Billing Question, Service Outage, Payments */
select reason, count(reason) from call_center group by reason;/* Billing Question-23462, Service Outage-4730, Payments-4749*/

/* city*/
select count(city) from call_center;           /*no null values*/
select count(distinct(city)) from call_center; /*461 diff cities*/
select city, count(city) from call_center group by city;/*show the count of diff cities*/

/* state*/
select count(distinct(state)) from call_center; /*51 diff states*/
select state, count(state) from call_center group by state;

/*channel*/
select distinct(channel) from call_center;  /*4 - Call-Center, Chatbot, Email, Web*/
select channel, count(channel) from call_center group by channel;/*Call-Center-10639, Chatbot-8256, Email-7470, Web-6576*/


/*response_time*/
select distinct(response_time) from call_center;         /*3- Within SLA - 20625, Above SLA-4168, Below SLA-8148*/
select response_time, count(response_time) from call_center group by response_time order by count(response_time); /* count of category wise distinct values*/

/*call_duration*/
select avg(call_duration) from call_center;       /*mean is 24.98*/
select variance(call_duration) from call_center; /*variance is 138.98*/
select min(call_duration) from call_center;  /*min time is 5min*/
select max(call_duration) from call_center;  /*maz time is 45min*/
select stddev(call_duration) from call_center; /*st. dev is 11.78*/
/*data points compact and are close to the mean*/

/*call_center*/
select distinct(call_center) from call_center; /*4-Los Angeles/CA-13734, Baltimore/MD-11012, Denver/CO-2776, Chicago/IL-5419 */
select call_center, count(call_center) from call_center group by call_center;

/*BIVARIATE ANALYSIS*/

/*sentiment with csat_score*/
select sentiment, avg(csat_score) from call_center group by sentiment; /*gives average csat score acc to sentiment*/

/*sentiment with city*/
select city, sentiment, count(sentiment) from call_center group by city, sentiment order by city; /*city wise count of sentiment*/
select city, sentiment, count(sentiment) from call_center group by city, sentiment order by count(sentiment) desc; /*max count(395) of sentiment i.e. negative in washington*/
select city, sentiment, count(sentiment) from call_center group by city, sentiment order by count(sentiment); /*min no of count(1) i.e. positive or very positive occurs in many city*/

/*sentiment with state*/
select state, sentiment, count(sentiment) from call_center group by state, sentiment order by state; /* state wise count of sentiment*/
select state, sentiment, count(sentiment) from call_center group by state, sentiment order by count(sentiment) desc; /*max count(265) of sentiment which is negative in state Alabama*/
select state, sentiment, count(sentiment) from call_center group by state, sentiment order by count(sentiment); /*min no of sentiment is 1 which is very positive  in Maine and Rhode island*/

/*there are more negative or very negative feedback(sentiment) city wise as well as statewise both as compared to positive feedback*/

/*sentiment with channel*/
select channel, sentiment, count(sentiment) from call_center group by channel, sentiment; /*channel wise count of sentiment*/

/*sentiment with call_duration*/
select sentiment, avg(call_duration) from call_center group by sentiment ; /*sentiment wise average call duration*/

/*sentiment with call_center*/
select call_center, sentiment, count(sentiment) from call_center group by call_center, sentiment order by count(sentiment);
/*call center wise count of sentiment and min no of sentiment is 243 which is positive in denver/CO and max is 4601 which is negative in los angeles*/

/*csat_score with reason*/
select reason, csat_score, count(csat_score) from call_center group by reason, csat_score; /*reason wise csat_score*/
select reason, csat_score, count(csat_score) from call_center group by reason, csat_score order by count(csat_score); 
 /*the max csat_score i.e. 10 given by only 70 people and the reason for the call is service outage and the min rating i.e. 1 given by 69 persons related to service outage*/
 /*max no of people giving csat rating as 5 related to billing question which means who has the reason related to billing question is 50% satisfied*/
 
/* csat_score with city*/
select city, avg(csat_score) from call_center group by city order by avg(csat_score); /*citywise csat_score, the people living in lake charles gives the max csat_score as an avg of 8*/

/*csat_score with state*/
select state, avg(csat_score) from call_center group by state order by avg(csat_score); /*statewise csat_score, the people living in vermont gives the max csat_score as an avg of 6*/

/*csat_score with channel*/
select channel, avg(csat_score) from call_center group by channel order by avg(csat_score); /*channelwise csat_score, all the channels gives amlost same csat_score as an avg of 5*/

/*csat_score with call_center*/
select call_center, avg(csat_score) from call_center group by call_center order by avg(csat_score); /*callcenter wise average csat_score, almost all the call_center is having csat_score as an avg of 5*/

/*reason with city*/
select city, reason, count(reason) from call_center group by city, reason order by count(reason); /*city wise no of people who has different reasons*/

/*reason with state*/
select state, reason, count(reason) from call_center group by state, reason order by count(reason); /*statewise count of reason*/
/*max no of people(2588) who belongs to california call for the reason as billing question*/

/*reason with call_center*/
select call_center, reason, count(reason) from call_center group by call_center, reason order by count(reason);
/*max no of people(9781) whose reason is related to billing question called in the call center located in los angeles/CA */

/*city with channel*/
select city, channel, count(channel) from call_center group by city, channel order by city; /*citywise count of channel*/

/*state with channel*/
select state, channel, count(channel) from call_center group by state, channel order by state; /*satte wise count of channel*/

/*call_duration with reason*/
select reason, avg(call_duration) from call_center group by reason; /*average call_duration is almost same for all the reason*/

/*call_duration with city*/
select city, avg(call_duration) from call_center group by city order by avg(call_duration) desc; /*max value of avg call_duration is 44.00 which is in Arvada*/
select city, avg(call_duration) from call_center group by city order by avg(call_duration); /*min value of avg call_duration is 9.00 which is in Sparks*/

/*call_duration with state*/
select state, avg(call_duration) from call_center group by state order by avg(call_duration) desc; /*max value of avg call_duration is 33.75 which is in Vermont*/
select state, avg(call_duration) from call_center group by state order by avg(call_duration); /*min value of avg call_duration is 18.25 which is in New Hampshire*/

/*call_duration with channel*/
select channel, avg(call_duration) from call_center group by channel; /*the value of call_duration is almost same for all the channel*/

/*call_duration with response_time*/
select response_time, avg(call_duration) from call_center group by response_time; /*the value of call_duration is almost same for all the response_time*/

/*call_duration with call_center*/
select call_center, avg(call_duration) from call_center group by call_center; /*the value of call_duration is almost same for all the call_center/
