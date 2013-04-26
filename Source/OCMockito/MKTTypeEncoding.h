//
//  OCMockito - MKTTypeEncoding.h
//  Copyright 2013 Jonathan M. Reid. All rights reserved.
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//


static inline BOOL MKTTypeEncodingIsObjectOrClass(const char *type)
{
    return *type == @encode(id)[0] || *type == @encode(Class)[0];
}
