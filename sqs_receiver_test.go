package main

import (
	"context"
	"log"
	"testing"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
)

func TestRunSQSReceiver(t *testing.T) {
	cfg, err := config.LoadDefaultConfig(context.Background())
	if err != nil {
		log.Fatalf("Unable to load the default config, %v", err)
	}

	sqsClient := sqs.NewFromConfig(cfg)

	queueURL := "https://sqs.eu-west-2.amazonaws.com/376503212453/orders"

	for {
		resp, err := sqsClient.ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            &queueURL,
			MaxNumberOfMessages: 1,
			WaitTimeSeconds:     10,
		})

		if err != nil {
			log.Printf("Unable to receive any messages, %v", err)
			continue
		}

		if len(resp.Messages) > 0 {
			message := resp.Messages[0]
			log.Printf("Message ID: %s\n", *message.MessageId)
			log.Printf("Message Body: %s\n", *message.Body)

			_, err := sqsClient.DeleteMessage(context.Background(), &sqs.DeleteMessageInput{
				QueueUrl:      &queueURL,
				ReceiptHandle: message.ReceiptHandle,
			})

			if err != nil {
				log.Printf("Unable to delete the message, %v", err)
			} else {
				log.Println("Message has been deleted successfully")
			}
		} else {
			log.Println("No messages received")
		}
	}
}
