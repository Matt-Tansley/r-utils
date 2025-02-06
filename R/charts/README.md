# charts

## bar_chart_missing_values

Demo of a stacked bar chart where the x axis is some categorical variable. In some cases, you might know all of the potential categories, but your data might not have all the categories. You might still want to show in the graph that there are 0 data entries for the categories that are not in your data, and this is exactly what this bar chart demoes. 

Real life use-case: exporting data from Jira, and plotting counts of tickets using priority as category. Priority can range from 1 to 4. The data you pull has not priority 3 tickets, but you still want to represent this on the graph rather than just not visualise the category.