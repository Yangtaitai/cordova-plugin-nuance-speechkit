//
//  SKSConfiguration.mm
//  SpeechKitSample
//
//  All Nuance Developers configuration parameters can be set here.
//
//  Copyright (c) 2015 Nuance Communications. All rights reserved.
//

#import "SKSConfiguration.h"

// All fields are required.
// Your credentials can be found in your Nuance Developers portal, under "Manage My Apps".
NSString* SKSAppKey = @"";
NSString* SKSAppId = @"";
NSString* SKSServerHost = @"";
NSString* SKSServerPort = @"";

NSString* SKSLanguage = @"eng-USA";

NSString* SKSServerUrl = [NSString stringWithFormat:@"nmsps://%@@%@:%@", SKSAppId, SKSServerHost, SKSServerPort];

// Only needed if using NLU/Bolt
NSString* SKSNLUContextTag = @"M5638_A2528_V1";

