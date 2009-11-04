(use gauche.test)
(test-start "naoyat.printf")

(use naoyat.printf)
(test-module 'naoyat.printf)


(test-section "escaped symbols")
(test* "\\t" "\t" (sprintf "\t"))
(test* "\\n" "\n" (sprintf "\n"))
(test* "\\\"" "\"" (sprintf "\""))
(test* "\\\\" "\\" (sprintf "\\"))
(test* "%%" "%" (sprintf "%%"))

(test-section "%d")
(test* "%d 1" "1" (sprintf "%d" 1))
(test* "%3d 1" "  1" (sprintf "%3d" 1))
(test* "%3d 1111" "1111" (sprintf "%3d" 1111))
(test* "%03d 1" "001" (sprintf "%03d" 1))
(test* "%-3d" "1  " (sprintf "%-3d" 1))
(test* "%+d 1" "+1" (sprintf "%+d" 1))
(test* "%+3d 1" " +1" (sprintf "%+3d" 1))

(test* "%d zero" "0" (sprintf "%d" 0))

(test* "%d minusvalue" "-1" (sprintf "%d" -1))
(test* "%3d minusvalue" " -1" (sprintf "%3d" -1))
;(test* "%03d minusvalue" "-01" (sprintf "%03d" -1))
(test* "%-d minusvalue" "-1" (sprintf "%-d" -1))
(test* "%+d minusvalue" "-1" (sprintf "%+d" -1))
(test* "%+3d minusvalue" " -1" (sprintf "%+3d" -1))

(test-section "%d with non-integer values")
(test* "%d float 2.71828" "2" (sprintf "%d" 2.71828))
(test* "%d rational 3/2" "1" (sprintf "%d" 3/2))
(test* "%d string \"123\"" "123" (sprintf "%d" "123"))
(test* "%d string \"abc\"" "0" (sprintf "%d" "abc"))
(test* "%d symbol '1" "1" (sprintf "%d" '1))
(test* "%d symbol 'a" "0" (sprintf "%d" 'a))

(test-section "%i %u")
(test* "%i" "999" (sprintf "%i" 999))
(test* "%u" "999" (sprintf "%u" 999))

(test-section "%x %X")
(test* "%x 15" "f" (sprintf "%x" 15))
(test* "%3x 15" "  f" (sprintf "%3x" 15))
(test* "%03x 15" "00f" (sprintf "%03x" 15))
(test* "%03x 65535" "ffff" (sprintf "%03x" 65535))
;(test* "%-3x 15" "f  " (sprintf "%-3x" 15))

(test* "%X 15" "F" (sprintf "%X" 15))
(test* "%3X 15" "  F" (sprintf "%3X" 15))
(test* "%03X 15" "00F" (sprintf "%03X" 15))
(test* "%03X 65535" "FFFF" (sprintf "%03X" 65535))
;(test* "%-3x 15" "f  " (sprintf "%-3x" 15))

(test-section "%o")
(test* "%o 9" "11" (sprintf "%o" 9))
(test* "%3o 9" " 11" (sprintf "%3o" 9))
(test* "%03o 9" "011" (sprintf "%03o" 9))
(test* "%3o 255" "377" (sprintf "%3o" 255))
(test* "%3o 511" "777" (sprintf "%3o" 511))
(test* "%3o 585" "1111" (sprintf "%3o" 585))
;(test* "%-3o" "11 " (sprintf "%-3o" 9))

(test-section "%b") ; original feature
(test* "%b 2" "10" (sprintf "%b" 2))
(test* "%3b 2" " 10" (sprintf "%3b" 2))
(test* "%03b 2" "010" (sprintf "%03b" 2))
(test* "%3b 15" "1111" (sprintf "%3b" 15))
;(test* "%-3b 2" "10 " (sprintf "%-3b" 3))

(test-section "%c")
(test* "%c 9" "\t" (sprintf "%c" 9))
(test* "%c 13" "\r" (sprintf "%c" 13))
(test* "%c 32" " " (sprintf "%c" #x20)) ; 32
(test* "%c 55" "7" (sprintf "%c" #x37)) ; 55
(test* "%c 69" "E" (sprintf "%c" #x45)) ; 69
(test* "%c 12354" "あ" (sprintf "%c" #x3042)) ; = 12354

(test* "%c \"abc\"" "a" (sprintf "%c" "a"))
(test* "%c \"いろは\"" "い" (sprintf "%c" "いろは"))

(test-section "%s")
(test* "%s" "\n" (sprintf "%s" "\n"))
(test* "%s" "a" (sprintf "%s" "a"))
(test* "%3s" "   " (sprintf "%3s" ""))
(test* "%3s" "  a" (sprintf "%3s" "a"))
(test* "%3s" " aa" (sprintf "%3s" "aa"))
(test* "%3s" "aaa" (sprintf "%3s" "aaa"))
(test* "%3s" "aaaa" (sprintf "%3s" "aaaa"))
(test* "%-3s" "   " (sprintf "%-3s" ""))
(test* "%-3s" "a  " (sprintf "%-3s" "a"))
(test* "%-3s" "aa " (sprintf "%-3s" "aa"))
(test* "%-3s" "aaa" (sprintf "%-3s" "aaa"))
(test* "%-3s" "aaaa" (sprintf "%-3s" "aaaa"))

(test-section "%s with non-string values")
(test* "%s integer 5" "5" (sprintf "%s" 5))
(test* "%s float 3.14" "3.14" (sprintf "%s" 3.14))
(test* "%s rational 3/2" "3/2" (sprintf "%s" 3/2))
(test* "%s symbol 'abc" "abc" (sprintf "%s" 'abc))
(test* "%s list (1 2 3)" "(1 2 3)" (sprintf "%s" '(1 2 3)))
(test* "%s empty list ()" "()" (sprintf "%s" '()))
(test* "%s dotted list (1 . 2)" "(1 . 2)" (sprintf "%s" '(1 . 2)))
(test* "%s #t" "#t" (sprintf "%s" #t))
(test* "%s #f" "#f" (sprintf "%s" #f))

(test-section "%f")
(test* "%f" "3.140000" (sprintf "%f" 3.14))
(test* "%f" "3.141593" (sprintf "%f" 3.1415926))

(test* "%f" "-3.140000" (sprintf "%f" -3.14))
(test* "%f" "-3.141593" (sprintf "%f" -3.1415926))

(test* "%f" "-1.100000" (sprintf "%f" -1.1))
(test* "%f" "-1.123457" (sprintf "%f" -1.12345678))
(test* "%f" "-1.789000" (sprintf "%f" -1.789))
(test* "%f" "-1.789000" (sprintf "%f" -1.78900001))

(test* "%f" "-0.100000" (sprintf "%f" -0.1))
(test* "%f" "-0.123457" (sprintf "%f" -0.12345678))
(test* "%f" "-0.789000" (sprintf "%f" -0.789))
(test* "%f" "-0.789000" (sprintf "%f" -0.78900001))


(test* "%.0f" "3" (sprintf "%.0f" 3.14))
(test* "%.1f" "3.1" (sprintf "%.1f" 3.14))
(test* "%.2f" "3.14" (sprintf "%.2f" 3.14))
(test* "%.3f" "3.140" (sprintf "%.3f" 3.14))
(test* "%.4f" "3.1400" (sprintf "%.4f" 3.14))

(test* "%1.0f 3.14" "3" (sprintf "%1.0f" 3.14))
(test* "%1.1f 3.14" "3.1" (sprintf "%1.1f" 3.14))
(test* "%1.2f 3.14" "3.14" (sprintf "%1.2f" 3.14))
(test* "%1.0f 3.15" "3" (sprintf "%1.0f" 3.15))
(test* "%1.1f 3.15" "3.2" (sprintf "%1.1f" 3.15))
(test* "%1.2f 3.15" "3.15" (sprintf "%1.2f" 3.15))

(test* "%2.0f" " 3" (sprintf "%2.0f" 3.14))
(test* "%2.1f" "3.1" (sprintf "%2.1f" 3.14))
(test* "%2.2f" "3.14" (sprintf "%2.2f" 3.14))
(test* "%-2.0f" "3 " (sprintf "%-2.0f" 3.14))
(test* "%-2.1f" "3.1" (sprintf "%-2.1f" 3.14))
(test* "%-2.2f" "3.14" (sprintf "%-2.2f" 3.14))

(test* "%3.0f" "  3" (sprintf "%3.0f" 3.14))
(test* "%3.1f" "3.1" (sprintf "%3.1f" 3.14))
(test* "%3.2f" "3.14" (sprintf "%3.2f" 3.14))
(test* "%3.3f" "3.140" (sprintf "%3.3f" 3.14))
(test* "%-3.0f" "3  " (sprintf "%-3.0f" 3.14))
(test* "%-3.1f" "3.1" (sprintf "%-3.1f" 3.14))
(test* "%-3.2f" "3.14" (sprintf "%-3.2f" 3.14))
(test* "%-3.3f" "3.140" (sprintf "%-3.3f" 3.14))

(test* "%4.0f" "   3" (sprintf "%4.0f" 3.14))
(test* "%4.1f" " 3.1" (sprintf "%4.1f" 3.14))
(test* "%4.2f" "3.14" (sprintf "%4.2f" 3.14))
(test* "%4.3f" "3.140" (sprintf "%4.3f" 3.14))
(test* "%4.4f" "3.1400" (sprintf "%4.4f" 3.14))
(test* "%-4.0f" "3   " (sprintf "%-4.0f" 3.14))
(test* "%-4.1f" "3.1 " (sprintf "%-4.1f" 3.14))
(test* "%-4.2f" "3.14" (sprintf "%-4.2f" 3.14))
(test* "%-4.3f" "3.140" (sprintf "%-4.3f" 3.14))
(test* "%-4.4f" "3.1400" (sprintf "%-4.4f" 3.14))

(test* "%5.0f" "    3" (sprintf "%5.0f" 3.14))
(test* "%5.1f" "  3.1" (sprintf "%5.1f" 3.14))
(test* "%5.2f" " 3.14" (sprintf "%5.2f" 3.14))
(test* "%5.3f" "3.140" (sprintf "%5.3f" 3.14))
(test* "%5.4f" "3.1400" (sprintf "%5.4f" 3.14))
(test* "%5.5f" "3.14000" (sprintf "%5.5f" 3.14))
(test* "%-5.0f" "3    " (sprintf "%-5.0f" 3.14))
(test* "%-5.1f" "3.1  " (sprintf "%-5.1f" 3.14))
(test* "%-5.2f" "3.14 " (sprintf "%-5.2f" 3.14))
(test* "%-5.3f" "3.140" (sprintf "%-5.3f" 3.14))
(test* "%-5.4f" "3.1400" (sprintf "%-5.4f" 3.14))
(test* "%-5.5f" "3.14000" (sprintf "%-5.5f" 3.14))

(test-section "%*.*f")
(test* "%4.2f" "3.14" (sprintf "%4.2f" 3.14159))
(test* "%*.2f, 4" "3.14" (sprintf "%*.2f" 4 3.14159))
(test* "%4.*f, 2" "3.14" (sprintf "%4.*f" 2 3.14159))
(test* "%*.*f, 4, 2" "3.14" (sprintf "%*.*f" 4 2 3.14159))

(test-section "%e %E")
(test* "%e 0.0000314" "3.140000e-05" (sprintf "%e" 0.0000314))
(test* "%e 0.000314" "3.140000e-04" (sprintf "%e" 0.000314))
(test* "%e 0.00314" "3.140000e-03" (sprintf "%e" 0.00314))
(test* "%e 0.0314" "3.140000e-02" (sprintf "%e" 0.0314))
(test* "%e 0.314" "3.140000e-01" (sprintf "%e" 0.314))
(test* "%e 3.14" "3.140000e+00" (sprintf "%e" 3.14))
(test* "%e 31.4" "3.140000e+01" (sprintf "%e" 31.4))
(test* "%e 314" "3.140000e+02" (sprintf "%e" 314))
(test* "%e 3140" "3.140000e+03" (sprintf "%e" 3140))
(test* "%e 31400" "3.140000e+04" (sprintf "%e" 31400))
(test* "%e 314000" "3.140000e+05" (sprintf "%e" 314000))
(test* "%.0e 31415926" "3e+07" (sprintf "%.0e" 31415926))
(test* "%.1e 31415926" "3.1e+07" (sprintf "%.1e" 31415926))
(test* "%.2e 31415926" "3.14e+07" (sprintf "%.2e" 31415926))
(test* "%.3e 31415926" "3.142e+07" (sprintf "%.3e" 31415926))
(test* "%.4e 31415926" "3.1416e+07" (sprintf "%.4e" 31415926))
(test* "%.5e 31415926" "3.14159e+07" (sprintf "%.5e" 31415926))

(test* "%E" "3.140000E+00" (sprintf "%E" 3.14))

(test-section "%g")
(test* "%g" "3" (sprintf "%g" 3.0))
(test* "%g" "3.14" (sprintf "%g" 3.14))
(test* "%g" "-3.14" (sprintf "%g" -3.14))
(test* "%g" "3.1415926" (sprintf "%g" 3.1415926))

(test-end)
