# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")
df


# preview top 5 rows
df.head()
# shape of dataframe
df.shape
# see data frame information
df.info()

# TODO - convert order date and ship date to datetime in the original dataframe
# y = 2020 ขึ้นไป
# Y = 2019 ลงมา
df['Order Date'] = pd.to_datetime(df['Order Date'], format = '%m/%d/%Y')
df['Ship Date'] = pd.to_datetime(df['Ship Date'], format = '%m/%d/%Y')
print(df['Order Date'].dtype)
print(df['Ship Date'].dtype)

# TODO - count nan in postal code column
count_nan = df['Postal Code'].isna().sum()
print(f"count nan postal code : {count_nan}")

# TODO - filter rows Postal Code with missing values
miss_val = df[df['Postal Code'].isna()]
miss_val

# Data Analysis Part
# Answer 10 below questions to get credit from this course. Write pandas code to find answers.

# TODO 01 - how many columns, rows in this dataset
df.shape
print(f"it has {df.shape[0]} row")
print(f"it has {df.shape[1]} column")

# TODO 02 - is there any missing values?, if there is, which column? how many nan values?
miss_df = df.isna().sum()
miss_df = pd.DataFrame(miss_df).reset_index()
miss_df.columns =['column', 'nan']
miss_df.query('nan > 0')

# TODO 03 - your friend ask for `California` data, filter it and export csv for him
california_df = df.query('State == "California"')
california_df.to_csv('california.csv')

# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
filter_df = df[ ((df['State'] == "California") | (df['State'] == "Texas")) & (df['Order Date'].dt.year == 2017) ]
filter_df
filter_df.to_csv('filter_df.csv')

# TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017

# filter 2017
df_2017 = df[df['Order Date'].dt.year == 2017]

# select sales 2017
df_2017_sales = df_2017['Sales']

# summarize
sales_company = df_2017_sales.agg(['sum', 'mean', 'std']).reset_index().round(2)
sales_company

# TODO 06 - which Segment has the highest profit in 2018
df.head()
df.tail()

# filter 2018
df_2018 = df[df['Order Date'].dt.year == 2018]

# group by segment and profit then summarize
high_profit_2018 = df_2018.groupby('Segment')['Profit'].agg(['sum'])\
                    .sort_values('sum', ascending = False).reset_index().round(2)

high_profit_2018['segment_profit'] = high_profit_2018['sum']
high_profit_2018.drop(labels = 'sum', axis = 1)

# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019

# filter years = 2019
df_2019 = df[df['Order Date'].dt.year == 2019]
df_2019.head()

# filter between 15 April 2019 - 31 December 2019
df_2019_filter = (df_2019['Order Date'] >= '2019-04-15') & (df_2019['Order Date'] <= '2019-12-31')

df_2019_filter = df_2019[df_2019_filter]
df_2019_filter.head()

# group by and summarize
least_total_sales = df_2019_filter.groupby('State')['Sales'].agg('sum')\
                    .reset_index().sort_values('Sales', ascending = True)

least_total_sales.head(5)

# filter years = 2019
df_2019 = df[df['Order Date'].dt.year == 2019]
df_2019.head()

# filter between 15 April 2019 - 31 December 2019
df_2019_filter = df_2019.query('`Order Date` >= "2019-04-15" & `Order Date` <= "2019-12-31"')
df_2019_filter.head()

# group by and summarize
least_total_sales = df_2019_filter.groupby('State')['Sales'].agg('sum')\
                    .reset_index().sort_values('Sales', ascending = True)

least_total_sales.head(5)

# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25%

df.head()

# filter 2019
df_2019_2 = df[df['Order Date'].dt.year == 2019]
df_2019_2.head()

# group by and summarize
df_2019_total_sales = df_2019_2.groupby('Region')['Sales'].agg('sum').reset_index()

# build total sales
total_sales = df_2019_total_sales['Sales'].sum()

# percentage calculation
df_2019_total_sales['Percentage'] = (df_2019_total_sales['Sales'] / total_sales) * 100

df_2019_total_sales.round(2).head()

# top 10 popular products in total sales
# group by and summarize then count and sort
df_2019_20_sales = df_2019_20.groupby('Product Name')['Sales'].agg('sum')\
                    .reset_index().sort_values('Sales', ascending = False)

df_2019_20_sales.head(10)


# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020
import pandas as pd
# filter 2019 - 2020
df_2019_20 = df[ (df['Order Date'].dt.year == 2019) | (df['Order Date'].dt.year == 2020)] [ ['Order Date','Order ID', 'Product Name', 'Sales'] ]

# top 10 popular products in number of orders
# group by and summarize then count and sort
df_2019_20_popular = df_2019_20.groupby('Product Name')['Order ID'].agg('count')\
                    .reset_index().sort_values('Order ID', ascending = False)

df_2019_20_popular.head(10)
df_2019_20_popular2= pd.DataFrame(df_2019_20_popular)

# top 10 popular products in total sales
# group by and summarize then count and sort
df_2019_20_sales = df_2019_20.groupby('Product Name')['Sales'].agg('sum')\
                    .reset_index().sort_values('Sales', ascending = False)

df_2019_20_sales.head(10)
df_2019_20_sales_2 = pd.DataFrame(df_2019_20_sales)

# Merge DataFrame
top10 = pd.merge(df_2019_20_popular2, df_2019_20_sales_2, on = 'Product Name')

top10.sort_values('Sales', ascending = False).head(10)

# TODO 10 - plot at least 2 plots, any plot you think interesting :)

# 1. sales group by Category by 2019
df_2019_segment = df[df['Order Date'].dt.year == 2019]

df_2019_seg_cat= df_2019_segment.groupby('Category')['Sales'].agg('sum')\
                .reset_index().sort_values('Sales', ascending = False)

df_2019_seg_cat.head()

df_2019_seg_cat.plot(x = 'Category', y = 'Sales', kind = 'bar'\
                     , color = ['yellow', 'red', 'green'], title = 'Sales by Category')

# 2. sales group by month in 2019
import matplotlib.pyplot as plt
df_year_2019 = df[df['Order Date'].dt.year == 2019]

df_trend_2019 = df_year_2019.groupby(df_year_2019['Order Date'].dt.month)['Sales']\
                .agg('sum').reset_index()

df_trend_2019.head()

df_trend_2019.plot(x = 'Order Date', y = 'Sales', kind = 'line', color = 'red'\
                   , title = 'Sales trend 2019')

# Change Name X and Y
plt.xlabel('Month') 
plt.ylabel('Sales')







