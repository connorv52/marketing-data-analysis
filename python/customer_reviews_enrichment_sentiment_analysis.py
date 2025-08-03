#!/usr/bin/env python
# coding: utf-8

# # Customer Reviews Enrichment & Sentiment Analysis

# While querying to clean and assess the overall picture of the marketing firm's (Shopverge) data, an opportunity to run sentiment analysis on the customer text reviews presented itself. Pairing this analysis with the numerical ratings given by customers should help give us a more clear picture of how they feel about certain products as well as serve as an opportunity for Shopverge to better structure their marketing campaigns. 

# In[1]:


pip install pandas nltk pyodbc sqlalchemy


# In[3]:


# Import the libraries we will require for sentiment analysis
import pandas as pd
import pyodbc
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer


# In[4]:


nltk.download('vader_lexicon')


# In[9]:


# We will need to define a function that fetches data from our SQL database using a SQL query
def fetch_data_from_sql():
    # Defines the connection string with parameters for the database connection
    conn_str = (
        "Driver={SQL Server};" # Driver for SQL Server
        "Server=DESKTOP-0J26I2S\\SQLEXPRESS;" # SQL Server Instance
        "Database=PortfolioProject_MarketingAnalytics;" # Database name
        "Trusted_Connection=yes;" # Windows Authentication 
    )
    conn = pyodbc.connect(conn_str) # Establishes the connection to the database
    
    query = """
    SELECT
        ReviewID,
        CustomerID,
        ProductID,
        ReviewDate,
        Rating,
        REPLACE(ReviewText, '  ', ' ') AS ReviewText
    FROM
        dbo.customer_reviews
    """ 
    # Defines the SQL query to fetch customer reviews data
    
    df = pd.read_sql(query, conn) # Executes the query and fetches the data into a DataFrame for easy analysis
    
    conn.close() #Closes the connection (free up resources)
    
    return df # Returns the fetched data as a DataFrame

customer_reviews_df = fetch_data_from_sql()

sia = SentimentIntensityAnalyzer()

# Function to calculate sentiment scores
def calculate_sentiment(review): 
    sentiment = sia.polarity_scores(review) # Sentiment scores for the review text
    return sentiment['compound'] # Compound scores, normalized between -1 (most negative) and 1 (most positive)

def categorize_sentiment(score, rating): # Function to categorize sentiment using both text AND rating
    if score > 0.05: # Positive sentiment score
        if rating >= 4:
            return 'Positive' # High rating, positive sentiment
        elif rating == 3:
            return 'Mixed Positive' # Neutral rating, positive sentiment
        else:
            return 'Mixed Negative' # Low rating, positive sentiment
    elif score < -0.05: # Negative sentiment score
        if rating <= 2:
            return 'Negative'# Low rating, negative sentiment
        elif rating == 3:
            return 'Mixed Negative' # Neutral rating, negative sentiment
        else:
            return 'Mixed Positive' # High rating, negative sentiment
    else: # Neutral sentiment score
        if rating >= 4:
            return 'Positive' # High rating, neutral sentiment
        elif rating <= 2:
            return 'Negative' # Low rating, neutral sentiment
        else:
            return 'Neutral' # Neutral rating, neutral sentiment

# Function to bucket sentiment scores into text ranges
def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0' # Strong positive sentiment
    elif 0.0 <= score < 0.5: 
        return '0.0 to 0.49' # Positive sentiment
    elif -0.5 <= score < 0.0:
        return '-0.49 to 0.0' # Negative sentiment
    else:
        return '-1.0 to -0.5' # Strong negative sentiment

# Apply sentiment analysis to calculate sentiment scores for each review
customer_reviews_df['SentimentScore'] = customer_reviews_df['ReviewText'].apply(calculate_sentiment)

# Apply sentiment categorization using both text and rating
customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(
    lambda row: categorize_sentiment(row['SentimentScore'], row['Rating']), axis=1)

# Apply sentiment bucketing to categorize scores into defined ranges
customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(sentiment_bucket)



# In[8]:


# Display the first few rows of the DatFrame with sentiment scores, categories, and buckets
print(customer_reviews_df.head())


# In[15]:


# Save the DataFrame with sentiment scores, categories, and buckets to a CSV file
customer_reviews_df.to_csv('Customer_Reviews_With_Sentiment_Analysis.csv', index=False)

