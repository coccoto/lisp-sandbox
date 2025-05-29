(defparameter todo-list '())

(defun show-menu ()
    (format t "~%=== ToDo Menu ===
1. タスクを追加する
2. 一覧を表示する
3. タスクを完了にする
4. プログラムを終了する
実行したい操作の番号を選択してください: "))

(defun read-choice ()
    (finish-output)
    (read))

(defun add-task ()
    (format t "タスク名を入力してください: ")
    (finish-output)
    (let ((task (read-line)))
        (push (list :task task :done nil) todo-list)
        (format t "タスクの追加が完了しました~%")))

(defun list-tasks ()
    (format t "=== ToDo List ===~%")
    (loop for task in (reverse todo-list)
          for i from 1
          do (format t "~d. [~a] ~a~%"
                     i
                     (if (getf task :done) "1" "0")
                     (getf task :task))))

(defun complete-task ()
    (list-tasks)
    (format t "完了にするタスク番号を選択してください: ")
    (finish-output)
    (let ((num (read)))
        (let ((index (- (length todo-list) num)))
            (when (and (>= index 0) (< index (length todo-list)))
                (setf (getf (nth index todo-list) :done) t)
                (format t "タスクを完了にしました~%")))))

(defun start-todo ()
    (loop
        (show-menu)
        (case (read-choice)
            (1 (add-task))
            (2 (list-tasks))
            (3 (complete-task))
            (4 (return (format t "プログラムを終了します~%")))
            (otherwise (format t "無効な選択です~%")))))
