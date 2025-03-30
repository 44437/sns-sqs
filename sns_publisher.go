package main

import (
	"context"
	"log"

	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sns"
)

func main() {
	message := "OK"
	messageGroupId := "specific-order-number"
	topicArn := "arn:aws:sns:eu-west-2:376503212453:orders20250330111340904700000002.fifo"

	sessionConf := session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))

	output, err := sns.New(sessionConf).PublishWithContext(
		context.Background(),
		&sns.PublishInput{
			Message:        &message,
			MessageGroupId: &messageGroupId,
			TopicArn:       &topicArn,
		},
	)

	if err != nil {
		log.Fatalln(err.Error())
	}

	log.Println(*output.MessageId)
}
