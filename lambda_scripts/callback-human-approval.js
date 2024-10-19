// Lambda function that will automatically approve any task 
// in a message published to an Amazon SNS topic

console.log('Loading function');
const AWS = require('aws-sdk');
const resultMessage = "Successful";

export const handler = async (event) => {
    const stepfunctions = new AWS.StepFunctions();
    
    let message = JSON.parse(event.Records[0].Sns.Message);
    let taskToken = message.TaskToken;
    
    console.log('Message received from SNS:', message); 
    console.log('Task token: ', taskToken);
    
    // Return task token to Step Functions
    
    let params = {
        output: JSON.stringify(resultMessage),
        taskToken: taskToken
    };
    
    console.log('JSON Returned to Step Functions: ', params);
    let myResult = await stepfunctions.sendTaskSuccess(params).promise();
    console.log('State machine - callback completed..');
    
    return myResult;
    
};