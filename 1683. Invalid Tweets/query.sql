SELECT 
    tweet_id
FROM 
    Tweets
WHERE 
    -- LENGTH(content) > 15
    CHAR_LENGTH > 15


-- LENGTH returns the number of bytes, whereas CHAR_LENGTH returns the number of characters.