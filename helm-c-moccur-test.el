;;;; unit test
;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/el-expectations.el")

(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "initialize test")
      (expect t
        (let (v)
          (helm-test-candidates
           '(((name . "TEST")
            (candidates "foo")
            (init . (lambda ()
                      (helm-c-moccur-initialize)
                      (setq v helm-c-moccur-helm-invoking-flag)))
            (cleanup . helm-c-moccur-clean-up))))
            v))
      (desc "cleanup test")
      (expect nil
        (let ((helm-c-moccur-helm-invoking-flag t))
          (helm-test-candidates
           '(helm-c-source-occur-by-moccur))
          helm-c-moccur-helm-invoking-flag))
      (desc "helm-c-source-occur-by-moccur")
      (expect '(("Occur by Moccur" ("    2 bbb")))
        (let ((buf (get-buffer-create "*test helm-c-moccur*")))
        (with-current-buffer buf
          (insert "aaa\nbbb\nccc")
          (prin1
           (helm-test-candidates
            '(helm-c-source-occur-by-moccur) "bbb")
           (kill-buffer buf)))))
      (desc "helm-c-moccur-bad-regexp-p")
      (expect t
        (when (helm-c-moccur-bad-regexp-p "\\_>") t))
      (expect t
        (when (helm-c-moccur-bad-regexp-p "\\_> ") t))
      (expect t
        (when (helm-c-moccur-bad-regexp-p " \\_>") t))
      (expect t
        (when (helm-c-moccur-bad-regexp-p " \\_> ") t))
      (expect t
        (when (helm-c-moccur-bad-regexp-p "g \\_> ") t))
      (expect t
        (when (helm-c-moccur-bad-regexp-p "g \\_>") t))
      (expect t
        (when (helm-c-moccur-bad-regexp-p " \\_> g") t))
      (expect nil
        (when (helm-c-moccur-bad-regexp-p "g\\_> ") t))
      (expect nil
        (when (helm-c-moccur-bad-regexp-p " g\\_>") t))
        )))
