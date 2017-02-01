//
//  Algorithm.swift
//  HRV-iPhone
//
//  Created by Garry Polykoff on 2/1/17.
//  Copyright © 2017 Nest. All rights reserved.
//



import Foundation



class Algorithm {


    
    static  var  LN_MEAN: Double = 3.00;
    static  var  LN_VAR: Double = 0.64;
    static  var  HRV_MEAN: Double = 60.26;
    static  var  HRV_VAR: Double = 9.92;

    
    // Function to calculate RMSSD;:
    


public static func calculateHRVScore(hrv: Double...) -> Int {
    
    var score:Double = 0.0
    var sum:Double = 0.0
    
    for  i in 0..<hrv.count-1 {
        
        // get differences between successive readings,
        // subject this difference in power of 2,
        // and sum them up
        sum += pow((hrv[i+1] - hrv[i]),2)
    }
    
    
    // divide sum by number of measurements and take square root of it.
     // take natural logarithm of the number above – this is is the result.
    
    score = log10(sqrt(sum / (Double(hrv.count) - 1)));
    print("ln(RMSSD): \(score)")
    
    return extrapolateScore(score: score, ln_mean: Algorithm.LN_MEAN, ln_variance: Algorithm.LN_VAR, score_mean: Algorithm.HRV_MEAN, score_variance: Algorithm.HRV_VAR)
    
    
}



// Function to “extrapolate” HRV score out of ln(RMSSD) mean and variance:

private static func extrapolateScore(score: Double, ln_mean: Double, ln_variance: Double, score_mean: Double, score_variance: Double) -> Int {
    
    
    
    var result: Int = 0;
    
    let factor = (abs(ln_mean - score))/ln_variance
    
   
    
    if score < ln_mean {
        
        result = (Int)(score_mean - score_variance * factor);
    } else {
        
        result = (Int)(score_mean + score_variance * factor);
        
    }
    
    return result
    }
    
}


