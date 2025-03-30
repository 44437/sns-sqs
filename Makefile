run-sns:
	go run sns_publisher.go
run-sqs:
	go test sqs_receiver_test.go -v
state-migration:
	cd terraform && terraform init -migrate-state
af:
	cd terraform && terraform apply -auto-approve
destroy-module:
	cd terraform && terraform destroy -target=module.sqs
fmt:
	cd terraform && terraform fmt -recursive