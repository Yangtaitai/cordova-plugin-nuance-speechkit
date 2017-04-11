#import "NuanceSpeechkitPlugin.h"
#import "SKSConfiguration.h"
#import <SpeechKit/SpeechKit.h>

// State Logic: IDLE -> LISTENING -> PROCESSING -> repeat
enum {
    SKSIdle = 1,
    SKSListening = 2,
    SKSProcessing = 3
};
typedef NSUInteger SKSState;

@interface NuanceSpeechkitPlugin () <SKTransactionDelegate> {
    SKSession* _skSession;
    SKTransaction *_skTransaction;
    SKSState _state;
}

@end

@implementation NuanceSpeechkitPlugin

@synthesize contextTag = _contextTag;
@synthesize language = _language;
@synthesize endpointer = _endpointer;
@synthesize interpretationResult = _interpretationResult;

- (void)pluginInitialize {

	 _endpointer = SKTransactionEndOfSpeechDetectionShort;
    _language = LANGUAGE;
    _contextTag = SKSNLUContextTag;
    _state = SKSIdle;
    _skTransaction = nil;
    
    // Create a session
    _skSession = [[SKSession alloc] initWithURL:[NSURL URLWithString:SKSServerUrl] appToken:SKSAppKey];
    
    if (!_skSession) {
         NSLog(@"INFO: NuanceSpeechkitPlugin initialization failure");
    }
    
    NSLog(@"INFO: NuanceSpeechkitPlugin initialized");
}

- (void)recognize:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        _interpretationResult = nil;
        
        // Start listening to the user.
        _skTransaction = [_skSession recognizeWithService:_contextTag
                                                detection:self.endpointer
                                                 language:self.language
                                                     data:nil
                                                 delegate:self];
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void)getState:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSInteger: _state];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}



- (void)getResult:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:_interpretationResult[@"interpretations"]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void)stopRecording:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        // Stop recording the user.
        [_skTransaction stopRecording];
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void)cancel:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        // Cancel the Reco transaction.
        // This will only cancel if we have not received a response from the server yet.
        [_skTransaction cancel];
    }];
}


# pragma mark - SKTransactionDelegate

- (void)transactionDidBeginRecording:(SKTransaction *)transaction
{
    NSLog(@"INFO: NuanceSpeechkitPlugin transactionDidBeginRecording");
    _state = SKSListening;
}

- (void)transactionDidFinishRecording:(SKTransaction *)transaction
{
    NSLog(@"INFO: NuanceSpeechkitPlugin transactionDidFinishRecording");
    _state = SKSProcessing;
}

- (void)transaction:(SKTransaction *)transaction didReceiveRecognition:(SKRecognition *)recognition
{
    NSLog(@"INFO: NuanceSpeechkitPlugin didReceiveRecognition: %@", recognition.text);
}

- (void)transaction:(SKTransaction *)transaction didReceiveServiceResponse:(NSDictionary *)response
{
	NSLog(@"INFO: NuanceSpeechkitPlugin didReceiveServiceResponse: %@", [response description]);
}

- (void)transaction:(SKTransaction *)transaction didReceiveInterpretation:(SKInterpretation *)interpretation
{
    NSLog(@"INFO: NuanceSpeechkitPlugin didReceiveInterpretation: %@", interpretation.result);
    _interpretationResult = interpretation.result;
}

- (void)transaction:(SKTransaction *)transaction didFinishWithSuggestion:(NSString *)suggestion
{
    NSLog(@"INFO: NuanceSpeechkitPlugin didFinishWithSuggestion");
    [self resetTransaction];
}

- (void)transaction:(SKTransaction *)transaction didFailWithError:(NSError *)error suggestion:(NSString *)suggestion
{
	NSLog(@"INFO: NuanceSpeechkitPlugin didReceiveInterpretation: %@. %@", [error description], suggestion);
    // Something went wrong. Ensure that your credentials are correct.
    // The user could also be offline, so be sure to handle this case appropriately.
    [self resetTransaction];
    
}

- (void)resetTransaction
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _skTransaction = nil;
        _state = SKSIdle;
    }];
}

// Test echo method
- (void)echo:(CDVInvokedUrlCommand *)command {
    NSString* phrase = [command.arguments objectAtIndex:0];
    NSLog(@"%@", phrase);
}


@end
