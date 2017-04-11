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
NSString* SKSAppKey = @"1a20cac298652bf8dfa2185f52e2da19972797fe0eb994c613f27413ddad1bf8cee5ba664ae55e29877689d95963f3f08a8aee9843825e5674d3695280854a4e";
NSString* SKSAppId = @"NMDPTRIAL_davisvarghese_wealthphase_com20161209113216";
NSString* SKSServerHost = @"nmsps.dev.nuance.com";
NSString* SKSServerPort = @"443";

NSString* SKSLanguage = @"eng-USA";

NSString* SKSServerUrl = [NSString stringWithFormat:@"nmsps://%@@%@:%@", SKSAppId, SKSServerHost, SKSServerPort];

// Only needed if using NLU/Bolt
NSString* SKSNLUContextTag = @"M5638_A2528_V1";

