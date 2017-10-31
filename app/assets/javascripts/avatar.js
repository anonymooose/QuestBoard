// const avatar = () => {
//   $('.avatar').each((i, el) => {
//     $(el).html('');

//     // $(el).append(`<img src="/assets/avatar/gender/${$(el).data('gender')}.svg">`);

//     // if ($(el).data('hair') > 0) {
//     //   $(el).append(`<img src="/assets/avatar/hair/${$(el).data('hair')}.svg">`);
//     // }

//     // if ($(el).data('top') > 0) {
//     //   $(el).append(`<img src="/assets/avatar/top/${$(el).data('top')}.svg">`);
//     // }

//     // ...
//     // $(el).append(`<img src="/assets/avatar/bottom/${$(el).data('bottom')}.svg">`);
//     // $(el).append(`<img src="/assets/avatar/shoes/${$(el).data('shoes')}.svg">`);

//     const avatar = {
//       gender: $(el).data('gender'),
//       hair: $(el).data('hair'),
//       top: $(el).data('top'),
//       bottom: $(el).data('bottom'),
//       shoes: $(el).data('shoes'),
//     };
//     console.log(avatar)
//     for (let type in avatar) {
//       if (type === 'gender' || avatar[type] > 0) {
//         $(el).append(`<img src="/assets/avatar/${type}/${avatar[type]}.svg">`);
//       }
//     }
//   });
// }

// avatar();



// $('.avatar-choice input').change(e => {
//   // "avatar[hair]" => "hair"
//   const type = $(e.currentTarget).attr('name').split('[')[1].slice(0, -1);
//   const value = parseInt($(e.currentTarget).val());
//   $('.avatar').data(type, value);
//   avatar();
// });
