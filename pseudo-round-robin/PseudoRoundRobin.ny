;nyquist plug-in
;version 4
;type tool
;name "Pseudo Round-Robin"
;author "G D Grey"
;copyright "Released under terms of the GNU General Public License v3.0"
;control variations "Number of variations" int "" 2 1 16
;control upbnd "Max initial speed up" float "%" 5.0 5.0 80.0  
;control lowbnd "Max initial slow down" float "%" -5.0 -80.0 -5.0 
;control pitchvar "Micro pitch variation" float "cents" 0.0 0.0 10.0
;control preservelengths "Preserve Lengths" choice "Off,On" 1

(dotimes (i variations)
  (aud-do "SelectTracks:Mode=\"Set\" Track=0 TrackCount=1") 
  (aud-do "Duplicate:")
)

(dotimes (i variations) 
  (aud-do (format nil "SelectTracks:Mode=\"Set\" Track=~S TrackCount=1" (+ i 1))) 
  (aud-do "SelTrackStartToEnd:")
  ; generate random parameters for the stretch
  (setf lowwt (/ (- 0 lowbnd) (+ (- 0 lowbnd) upbnd)))
  (if (< (rrandom) lowwt) 
    (progn 
      (setf rpcs (* (rrandom) (- 0 lowbnd)))
      (if (= preservelengths 1)
        (setf rpce rpcs)
        (setf rpce (* (rrandom) rpcs))
      )
      (setf rpcs (- 0 rpcs))
    )
    (progn 
      (setf rpcs (* (rrandom) upbnd))
      (if (= preservelengths 1)
        (setf rpce (- 0 rpcs))
        (setf rpce (- 0 (* (rrandom) rpcs)))
      )
    )
  )
 (setf pshift (* (rrandom) pitchvar))
 (when (< (rrandom) 0.5)
   (setf pshift (- 0 pshift))
 )
 (setf pshift (* 0.01 pshift)) 
 (setf pct (- (* 100 (power 2 (/ pshift 12))) 100))
 (aud-do (format nil "SlidingStretch: RatePercentChangeStart=~S RatePercentChangeEnd=~S PitchHalfStepsStart=~S PitchHalfStepsEnd=~S PitchPercentChangeStart=~S PitchPercentChangeEnd=~S" rpcs rpce pshift pshift pct pct))
)