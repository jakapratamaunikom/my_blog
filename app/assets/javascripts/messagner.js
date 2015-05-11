//= require messenger
//= require messenger-theme-future


displayNotices = function (notice){
  if (notice.length > 0) {
    Messenger({
      extraClasses: 'messenger-fixed messenger-on-right messenger-on-bottom',
    }).post({
        message: notice,
      })

  }
}

