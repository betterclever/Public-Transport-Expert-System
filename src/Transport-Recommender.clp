(deftemplate Bus
    (slot name (type STRING))
    (slot start_time (type INTEGER))
    (multislot stops (type STRING))
    (slot interval (type INTEGER))
    (slot is_ac))

(deftemplate Path
    (slot stop1 (type STRING))
    (slot stop2 (type STRING))
    (slot avg_time (type INTEGER))
    (slot traffic_intensity (type NUMBER))
    (slot is_safe)
    (slot fare (type INTEGER)))

(deftemplate Query
    (slot start (type STRING))
    (slot end (type STRING))
    (slot is_ac)
    (slot s_time (type NUMBER))
    )

(deftemplate Answer0
    (slot start)
    (slot end)
    (slot s_time)
    (slot bus (type STRING))
    (slot b_time (type INTEGER))
    (slot is_safe)
    (slot traffic_desc (type STRING))
    (slot traffic_intensity (type NUMBER))
    (slot journey_time (type INTEGER))
    (slot total_fare (type INTEGER)))

(deftemplate Answer1
    (slot start)
    (slot end)
    (slot s_time)
    (slot bus1 (type STRING))
    (slot bus2 (type STRING))
    (slot changeover_stop (type STRING))
    (slot traffic_desc (type STRING))
    (slot b1_b_time (type INTEGER))
    (slot is_safe)
    (slot traffic_intensity (type NUMBER))
    (slot journey_time (type INTEGER))
    (slot total_fare (type INTEGER)))

(deffacts paths "Path Information"
    (Path (stop1 "Narayana") (stop2 "Punjabi Bagh") (traffic_intensity 67) (is_safe YES) (avg_time 20) (fare 10))
    (Path (stop1 "Inderlok") (stop2 "Punjabi Bagh") (traffic_intensity 23) (is_safe NO) (avg_time 10)(fare 15))
    (Path (stop1 "Paschim Vihar") (stop2 "Punjabi Bagh") (traffic_intensity 15) (is_safe YES) (avg_time 5)(fare 20))
    (Path (stop1 "Shakarpur") (stop2 "Punjabi Bagh") (traffic_intensity 35) (is_safe YES) (avg_time 10)(fare 5))
    (Path (stop1 "Paschim Vihar") (stop2 "Peeragarhi") (traffic_intensity 55) (is_safe YES) (avg_time 15)(fare 20))
    (Path (stop1 "Peeragarhi") (stop2 "Rohini") (traffic_intensity 80) (is_safe NO) (avg_time 10)(fare 15))
    (Path (stop1 "Wazirpur") (stop2 "Rohini") (traffic_intensity 70) (is_safe YES) (avg_time 10)(fare 25))
    (Path (stop1 "Adarsh Nagar") (stop2 "Rohini") (traffic_intensity 43) (is_safe YES) (avg_time 10)(fare 30))
    (Path (stop1 "Wazirpur") (stop2 "Shakarpur") (traffic_intensity 30) (is_safe YES) (avg_time 10)(fare 40))
    (Path (stop1 "Wazirpur") (stop2 "Shalimar Bagh") (traffic_intensity 60) (is_safe NO) (avg_time 10)(fare 20))
    (Path (stop1 "Wazirpur") (stop2 "Azadpur") (traffic_intensity 60) (is_safe YES) (avg_time 10)(fare 35))
    (Path (stop1 "Adarsh Nagar") (stop2 "Azadpur") (traffic_intensity 22) (is_safe YES) (avg_time 10)(fare 25))
    (Path (stop1 "Model Town") (stop2 "Azadpur") (traffic_intensity 30) (is_safe YES) (avg_time 12)(fare 5))
    (Path (stop1 "Bypass") (stop2 "Azadpur") (traffic_intensity 11) (is_safe NO) (avg_time 10)(fare 15))
    (Path (stop1 "Bypass") (stop2 "Shalimar Bagh") (traffic_intensity 53) (is_safe YES) (avg_time 10)(fare 20))
    )


(deffacts buses "Bus Information"
    (Bus (name "A+") (start_time 600) (interval 40) (stops "Narayana" "Punjabi Bagh" "Shakarpur" "Wazirpur" "Azadpur" "Model Town") (is_ac YES))
    (Bus (name "B+") (start_time 600) (interval 40) (stops "Inderlok" "Punjabi Bagh" "Paschim Vihar" "Peeragarhi" "Rohini") (is_ac YES))
    (Bus (name "C+") (start_time 500) (interval 40) (stops "Model Town" "Azadpur" "Bypass" "Shalimar Bagh" "Wazirpur" "Rohini" "Adarsh Nagar") (is_ac YES))
    
    (Bus (name "D+") (start_time 600) (interval 20) (stops "Narayana" "Punjabi Bagh" "Shakarpur" "Wazirpur" "Azadpur" "Model Town") (is_ac NO))
    (Bus (name "E+") (start_time 600) (interval 20) (stops "Inderlok" "Punjabi Bagh" "Paschim Vihar" "Peeragarhi" "Rohini") (is_ac NO))
    (Bus (name "F+") (start_time 500) (interval 20) (stops "Model Town" "Azadpur" "Bypass" "Shalimar Bagh" "Wazirpur" "Rohini" "Adarsh Nagar") (is_ac NO))
    
    (Bus (name "A-") (start_time 600) (interval 40) (stops "Model Town" "Azadpur" "Wazirpur" "Shakarpur" "Punjabi Bagh" "Narayana") (is_ac YES))
    (Bus (name "B-") (start_time 600) (interval 40) (stops "Rohini" "Peeragarhi" "Paschim Vihar" "Punjabi Bagh" "Inderlok") (is_ac YES))
    (Bus (name "C-") (start_time 500) (interval 40) (stops "Adarsh Nagar" "Rohini" "Wazirpur" "Shalimar Bagh" "Bypass" "Azadpur" "Model Town") (is_ac YES))
    
    (Bus (name "D-") (start_time 600) (interval 20) (stops "Model Town" "Azadpur" "Wazirpur" "Shakarpur" "Punjabi Bagh" "Narayana") (is_ac NO))
    (Bus (name "E-") (start_time 600) (interval 20) (stops "Rohini" "Peeragarhi" "Paschim Vihar" "Punjabi Bagh" "Inderlok") (is_ac NO))
    (Bus (name "F-") (start_time 500) (interval 20) (stops "Adarsh Nagar" "Rohini" "Wazirpur" "Shalimar Bagh" "Bypass" "Azadpur" "Model Town") (is_ac NO))
    )

(deffunction get_time_from_string
    (?time_str)
    (return (+
            (*  (integer (sub-string 1 2 ?time_str)) 60)
            (integer (sub-string 4 5 ?time_str))
            )
        )
    )

(deffunction enter_info ()
    (printout t crlf "Enter Boarding Stop" crlf)
    (bind ?b_stop (readline))
    (printout t crlf "Enter Destination Stop" crlf)
    (bind ?d_stop (readline))
    (printout t crlf "Do you need AC Bus? (YES / NO)" crlf)
    (bind ?is_ac (readline))
    (printout t crlf "Enter Start Time in format hh:mm" crlf)
    (bind ?s_time (readline))
    (assert (Query
            (start ?b_stop)
            (end ?d_stop)
            (is_ac (if (eq ?is_ac "YES") then YES else NO))
            (s_time (get_time_from_string ?s_time))))
    )

(defquery find-path
    (declare (variables ?stop1 ?stop2))
    (or (Path (stop1 ?stop1) (stop2 ?stop2) (avg_time ?avg_time) (traffic_intensity ?t_int) (is_safe ?safe) (fare ?fare))
        (Path (stop1 ?stop2) (stop2 ?stop1) (avg_time ?avg_time) (traffic_intensity ?t_int) (is_safe ?safe) (fare ?fare))
        )
    )

(deffunction is_safe_between (?stop1 ?stop2)
    (bind ?result (run-query* find-path ?stop1 ?stop2))
    (bind ?path (?result next))
    (bind ?is_safe (?result get safe))
    (return ?is_safe))

(deffunction check_safety ($?stops)
    (if (= (length$ ?stops) 0) then (return YES))
    (if (= (length$ ?stops) 1) then (return YES))
    (bind ?sb (is_safe_between (first$ ?stops) (first$ (rest$ ?stops))))
    (bind ?sr (check_safety (rest$ ?stops)))
    (if (or (eq ?sb NO) (eq ?sr NO)) then (return NO) else (return YES))
    )

(deffunction find-route-safety (?stops1 ?stops2)
    (bind ?s1 (check_safety ?stops1))
    (bind ?s2 (check_safety ?stops2))
    (if (and (eq ?s1 YES) (eq ?s2 YES)) then (return YES) else (return NO))
    )

(deffunction traffic_between (?stop1 ?stop2)
    (bind ?result (run-query* find-path ?stop1 ?stop2))
    (bind ?path (?result next))
    (bind ?intensity (?result getInt t_int))
    (return ?intensity))

(deffunction calc_traffic ($?stops)
    (if (= (length$ ?stops) 0) then (return 0))
    (if (= (length$ ?stops) 1) then (return 0))
    (bind ?tr (traffic_between (first$ ?stops) (first$ (rest$ ?stops))))
    (bind ?tro (calc_traffic (rest$ ?stops)))
    (bind ?res
        (/
            (+
                (* (length$ ?stops) ?tro)
                ?tr
                )
            (length$ ?stops)
            )
        )
    (return ?res))

(deffunction find_traffic (?stops1 ?stops2)
    (if (= (length$ ?stops1) 0) then (return 0))
    (if (= (length$ ?stops2) 0) then (return 0))
    (bind ?tr1 (calc_traffic ?stops1))
    (bind ?tr2 (calc_traffic ?stops2))
    (bind ?res
        (/
            (+
                (* (length$ ?stops1) ?tr1)
                (* (length$ ?stops2) ?tr2)
                )
            (+
                (length$ ?stops1)
                (length$ ?stops2)
                )
            )
        )
    (return ?res)
    )

(deffunction time_between (?stop1 ?stop2)
    (bind ?result (run-query* find-path ?stop1 ?stop2))
    (bind ?path (?result next))
    (bind ?time (?result getInt avg_time))
    (return ?time))

(deffunction calc_jtime (?list)
    (if (= (length$ ?list) 1) then (return 0))
    (bind ?result (run-query* find-path (first$ ?list) (first$ (rest$ ?list))))
    (bind ?path (?result next))
    (bind ?time1 (+ (?result getInt avg_time) (calc_jtime (rest$ ?list))))
    (return ?time1)
    )

(deffunction calc_fare1 (?list)
    (if (= (length$ ?list) 1) then (return 0))
    (bind ?result (run-query* find-path (first$ ?list) (first$ (rest$ ?list))))
    (bind ?path (?result next))
    (bind ?fare1 (+ (?result getInt fare) (calc_fare1 (rest$ ?list))))
    (return ?fare1)
    )

(deffunction calc_fare (?list ?is_ac)
    (bind ?fare1 (calc_fare1 ?list))
    (bind ?fare2 (if (eq ?is_ac YES) then (* ?fare1 2) else ?fare1))
    (return ?fare2)
    )

(deffunction calc_offset ($?stops)
    (if (= (length$ ?stops) 1) then (return 0))
    (if (= (length$ ?stops) 0) then (return 0))
    (bind ?offset (time_between (first$ ?stops) (first$ (rest$ ?stops))))
    (return (+ ?offset (calc_offset (rest$ ?stops))))
    )

(deffunction find_board_time (?stops_before ?b_start ?b_interval ?s_time)
    (bind ?offset (calc_offset ?stops_before))
    (bind ?fr_time (+ ?b_start ?offset))
    (return (+ ?fr_time (* (+ 1 (integer (/ (- ?s_time ?fr_time 1) ?b_interval))) ?b_interval)))
    )


(defrule low-traffic-intensity
    ?f1 <-(or
        (Answer0 (traffic_intensity ?i&:(<= ?i 15)) (traffic_desc nil))
        (Answer1 (traffic_intensity ?i&:(<= ?i 15)) (traffic_desc nil))
        )
    =>
    (duplicate ?f1 (traffic_desc "Low"))
    (retract ?f1)
    )

(defrule medium-traffic-intensity
    ?f1 <-(or
        (Answer0 (traffic_intensity ?i&:(and (<= ?i 40) (> ?i 15))) (traffic_desc nil))
        (Answer1 (traffic_intensity ?i&:(and (<= ?i 40) (> ?i 15))) (traffic_desc nil))
        )
    =>
    (duplicate ?f1 (traffic_desc "Medium"))
    (retract ?f1)
    )

(defrule high-traffic-intensity
    ?f1 <-(or
        (Answer0 (traffic_intensity ?i&:(> ?i 40)) (traffic_desc nil))
        (Answer1 (traffic_intensity ?i&:(> ?i 40)) (traffic_desc nil))
        )
    =>
    (duplicate ?f1 (traffic_desc "High"))
    (retract ?f1)
    )

(deffunction get-time-string (?time)
    (return (str-cat (integer (/ ?time 60)) " hrs " (mod ?time 60) ""))
    )


(defrule recommend-no-stop-answer
    (Answer0
        (start ?start)
        (end ?end)
        (b_time ?b_time)
        (is_safe ?safe)
        (traffic_desc ?desc)
        (traffic_intensity ?tr)
        (bus ?B)
        (total_fare ?tfare)
        (journey_time ?jtime)
        )
    (test (neq ?desc nil))
    =>
    (printout t crlf
        "OPTION: " crlf crlf
        "Take Bus " ?B
        " at " (get-time-string ?b_time)
        " from " ?start " to " ?end
        ". " crlf ?desc " traffic is expected on this route. " crlf
        "This path is " (if (eq ?safe YES) then "" else "not ") "safe" crlf
        "Total fare is " ?tfare " rupees" crlf
        "Total journey time " ?jtime " minutes"crlf)
    )



(deffunction concatAppend$
    (?list ?new-ele)
    (bind ?length (length$ ?list))
    (bind ?length (+ ?length 1))
    (bind ?new-list (insert$ ?list ?length ?new-ele))
    (return ?new-list)
    )

(deffunction concatPrepend$
    (?new-ele ?list)
    (bind ?new-list (insert$ ?list 1 ?new-ele))
    (return ?new-list)
    )


(defrule recommend-one-stop-answer
    (Answer1
        (start ?start)
        (end ?end)
        (b1_b_time ?b_time)
        (is_safe ?safe)
        (traffic_intensity ?tr)
        (traffic_desc ?desc)
        (bus1 ?B1)
        (bus2 ?B2)
        (changeover_stop ?cstop)
        (total_fare ?tfare)
        (journey_time ?jtime)
        )
    (test (neq ?desc nil))
    =>
    (printout t crlf
        "OPTION: " crlf crlf
        "Take Bus " ?B1
        " at " (get-time-string ?b_time)
        " from " ?start " to " ?cstop
        " then take " ?B2
        " from " ?cstop " to " ?end
        ". " crlf ?desc " traffic is expected on this route. " crlf
        "This path is " (if (eq ?safe YES) then "" else "not ") "safe" crlf
        "Total fare is " ?tfare " rupees"crlf
        "Total journey time " ?jtime " minutes" crlf)
    )

(defrule same-source-dest
    (Query (start ?start) (end ?end))
    (test (eq ?start ?end))
    =>
    (printout t crlf "Destination and Source are same. You don't need to take a bus." crlf)
    )

(defrule find_bus_one_change
    
    (Query (start ?start) (end ?end) (is_ac ?is_ac) (s_time ?s_time))
    (Bus
        (name ?B1)
        (stops $?bef1 ?start $?bet1 ?X $?)
        (is_ac ?is_ac) (start_time ?b_start)
        (interval ?b_interval))
    (Bus
        (name ?B2)
        (stops $?bef2 ?X $?bet2 ?end $?)
        (is_ac ?is_ac))
    (test (not (member$ ?end ?bet1)))
    (test (not (member$ ?start ?bet2)))
    (test (neq ?B1 ?B2))
    (test (neq ?start ?end))
    =>
    
    (assert (Answer1
            (start ?start)
            (end ?end)
            (b1_b_time (find_board_time (concatAppend$ $?bef1 ?start) ?b_start ?b_interval ?s_time))
            (changeover_stop ?X)
            (is_safe (find-route-safety (concatAppend$ (concatPrepend$ ?start ?bet1) ?X) 
                    (concatAppend$ (concatPrepend$ ?X ?bet2) ?end)))
            (traffic_intensity (find_traffic (concatAppend$ (concatPrepend$ ?start ?bet1) ?X) 
                    (concatAppend$ (concatPrepend$ ?X ?bet2) ?end)))
            (total_fare  (+ (calc_fare (concatPrepend$ ?start (concatAppend$ $?bet1 ?X)) ?is_ac)
                 (calc_fare (concatPrepend$ ?X (concatAppend$ $?bet2 ?end)) ?is_ac)))
            (journey_time (+ (calc_jtime (concatAppend$ (concatPrepend$ ?start ?bet1) ?X))(calc_jtime (concatAppend$ (concatPrepend$ ?X ?bet2) ?end))))
            (bus1 ?B1)
            (bus2 ?B2)
            )
        )
    )

(defrule find_bus_no_change
    (Query (start ?start) (end ?end) (is_ac ?is_ac) (s_time ?s_time))
    (Bus
        (name ?B)
        (stops $?bef ?start $?bet ?end $?)
        (is_ac ?is_ac) (start_time ?b_start)
        (interval ?b_interval))
    (test (neq ?start ?end))
    =>
    (assert (Answer0
            (start ?start)
            (end ?end)
            (b_time (find_board_time (concatAppend$ $?bef ?start) ?b_start ?b_interval ?s_time))
            (is_safe (check_safety (concatPrepend$ ?start(concatAppend$ $?bet ?end))))
            (traffic_intensity (calc_traffic (concatPrepend$ ?start(concatAppend$ $?bet ?end))))
            (total_fare (calc_fare (concatPrepend$ ?start (concatAppend$ $?bet ?end)) ?is_ac))
            (journey_time (calc_jtime (concatPrepend$ ?start(concatAppend$ $?bet ?end))))
            (bus ?B)
            )
        )
    )

(reset)

(enter_info)
;(assert (Query(start "Shalimar Bagh")(end "Narayana") (is_ac YES) (s_time 820)))
;(printout t "SAFETY CHECK: " (check_safety "Narayana" "Punjabi Bagh" "Shakarpur" "Wazirpur" "Azadpur") crlf)

(run)
