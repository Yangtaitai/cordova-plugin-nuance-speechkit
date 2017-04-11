#import <Cordova/CDVPlugin.h>
#import <SpeechKit/SKTransaction.h>

@interface NuanceSpeechkitPlugin : CDVPlugin {
}

// Settings
@property (strong, nonatomic) NSString *contextTag;
@property (strong, nonatomic) NSString *language;
@property (assign, nonatomic) SKTransactionEndOfSpeechDetection endpointer;
@property (strong, nonatomic) NSDictionary *interpretationResult;

// The hooks for our plugin commands
- (void)recognize:(CDVInvokedUrlCommand *)command;
- (void)getState:(CDVInvokedUrlCommand *)command;
- (void)getResult:(CDVInvokedUrlCommand *)command;
- (void)stopRecording:(CDVInvokedUrlCommand *)command;
- (void)cancel:(CDVInvokedUrlCommand *)command;
- (void)echo:(CDVInvokedUrlCommand *)command;

@end
