#!/bin/bash
# Set the IFS to the pipeline character
IFS="|"

# Concatenate the list to a pipeline-separated string
failed_steps=$(echo "${my_list[*]}" | tr ' ' '|')

# Print the result
printf "%s\n" "$failed_steps"

# Set the SNS topic ARN and message to send
topic_arn="arn:aws:sns:us-west-2:123456789012:my-topic"
# Publish the message to the SNS topic
aws sns publish --topic-arn $topic_arn --message "$failed_steps"
# Check if the command had an error
if [ $? -ne 0 ]; then
  echo "Failed to send message"
else
  echo "Message sent to SNS successfully"
fi
