config: let
  inherit (config.scheme.withHashtag) base00 base01 base02 base03 base04 base07 base0C base0D base0F;
in {
  background = base00;
  buttons = {
    style = "default";
    icon_background = base01;
    borderColor = base0C;
    modules = {
      ram = {
        icon = base0D;
        icon_background = base0D;
        text = base0D;
        border = base0D;
        background = base01;
      };
      storage = {
        icon_background = base07;
        icon = base07;
        border = base07;
        background = base01;
        text = base07;
      };
      updates = {
        background = base01;
        icon_background = base0C;
        text = base0C;
        icon = base0C;
        border = base0C;
      };
      kbLayout = {
        icon = base0C;
        background = base01;
        icon_background = base0C;
        text = base0C;
        border = base0C;
      };
      weather = {
        icon_background = base0C;
        background = base01;
        icon = base0C;
        text = base0C;
        border = base0C;
      };
      power = {
        background = base01;
        icon = base07;
        icon_background = base07;
        border = base07;
      };
      cpu = {
        icon_background = base07;
        background = base01;
        icon = base07;
        text = base07;
        border = base07;
      };
      netstat = {
        icon = base07;
        background = base01;
        text = base07;
        icon_background = base07;
        border = base07;
      };
      submap = {
        background = base01;
        text = base07;
        border = base07;
        icon = base07;
        icon_background = base01;
      };
      hyprsunset = {
        icon = base0D;
        background = base01;
        icon_background = base0D;
        text = base0D;
        border = base0D;
      };
      hypridle = {
        icon = base07;
        background = base01;
        icon_background = base07;
        text = base07;
        border = base07;
      };
      cava = {
        text = base07;
        background = base01;
        icon_background = base01;
        icon = base07;
        border = base07;
      };
    };
    workspaces = {
      border = base00;
      numbered_active_highlighted_text_color = "#21252b";
      numbered_active_underline_color = "#ffffff";
    };
    notifications = {
      icon_background = base0C;
      border = base0C;
      total = base0C;
      icon = base0C;
      background = base01;
    };
    clock = {
      icon_background = base07;
      border = base07;
      icon = base07;
      text = base07;
      background = base01;
    };
    battery = {
      border = base0D;
      icon_background = base0D;
      icon = base0D;
      text = base0D;
      background = base01;
    };
    systray = {
      background = base01;
      border = base02;
      customIcon = base04;
    };
    bluetooth = {
      icon_background = "#89dbeb";
      border = base0C;
      icon = base0C;
      text = base0C;
      background = base01;
    };
    network = {
      icon_background = "#caa6f7";
      border = base0C;
      icon = base0C;
      text = base0C;
      background = base01;
    };
    volume = {
      icon_background = base0D;
      border = base0D;
      icon = base0D;
      text = base0D;
      background = base01;
    };
    windowtitle = {
      border = base07;
      icon_background = base07;
      icon = base07;
      text = base07;
      background = base01;
    };
    workspaces = {
      active = base07;
      occupied = base0D;
      available = base0C;
      hover = base02;
      background = base01;
    };
    dashboard = {
      border = base0D;
      icon = base0D;
      background = base01;
    };
    media = {
      icon_background = base0C;
      border = base0C;
      icon = base0C;
      text = base0C;
      background = base01;
    };
    icon = base0C;
    text = base0C;
    hover = base02;
    background = base01;
  };
  menus = {
    background = base00;
    check_radio_button = {
      background = base00;
      active = base0C;
    };
    text = base04;
    border.color = base02;
    popover = {
      border = base00;
      text = base0C;
      background = base00;
    };
    menu = {
      media = {
        card.color = base01;
        timestamp = base04;
      };
      notifications = {
        pager.button = base0C;
        scrollbar.color = base0C;
        pager.label = base0F;
        pager.background = base00;
      };
      power = {
        border.color = base02;
        background.color = base00;
        buttons = {
          sleep = {
            icon_background = base0C;
            text = base0C;
            background = base01;
            icon = base00;
          };
          logout = {
            icon = base00;
            background = base01;
            text = base07;
            icon_background = base07;
          };
          restart = {
            text = base0D;
            icon_background = base0D;
            icon = base00;
            background = base01;
          };
          shutdown = {
            icon = base00;
            background = base01;
            icon_background = base07;
            text = base07;
          };
        };
      };
      network = {
        switch = {
          enabled = base0C;
          disabled = base02;
          puck = base02;
        };
        scroller.color = base0C;
      };
      bluetooth.scroller.color = base0C;
      volume = {
        text = base04;
        card.color = base01;
        label.color = base0D;
      };
      dashboard = {
        powermenu = {
          shutdown = base07;
          confirmation = {
            deny = base07;
            confirm = base07;
            button_text = base00;
            body = base04;
            label = base0C;
            border = base02;
            background = base00;
            card = base01;
          };
        };
        monitors = {
          disk = {
            label = base07;
            bar = base07;
            icon = base07;
          };
          gpu = {
            label = base07;
            bar = base07;
            icon = base07;
          };
          ram = {
            label = base0D;
            bar = base0D;
            icon = base0D;
          };
          cpu = {
            label = base0D;
            bar = base0D;
            icon = base0D;
          };
          bar_background = base02;
        };
        directories = {
          right = {
            bottom.color = base0C;
            middle.color = base0C;
            top.color = base07;
          };
          left = {
            bottom.color = base0D;
            middle.color = base0D;
            top.color = base07;
          };
        };
        controls = {
          input = {
            text = base00;
            background = base07;
          };
          volume = {
            text = base00;
            background = base0D;
          };
          notifications = {
            text = base00;
            background = base0D;
          };
          bluetooth = {
            text = base00;
            background = base0C;
          };
          wifi = {
            text = base00;
            background = base0C;
          };
          disabled = base02;
        };
        shortcuts = {
          recording = base07;
          text = base00;
          background = base0C;
        };
        powermenu = {
          sleep = base0C;
          logout = base07;
          restart = base0D;
        };
        profile.name = base07;
        border.color = base02;
        background.color = base00;
        card.color = base01;
      };
      notifications = {
        switch = {
          puck = base02;
          disabled = base02;
          enabled = base0C;
        };
        clear = base07;
        switch_divider = base02;
        border = base02;
        card = base01;
        background = base00;
        no_notifications_label = base02;
        label = base0C;
      };
      clock = {
        weather = {
          hourly = {
            temperature = base07;
            icon = base07;
            time = base07;
          };
          thermometer = {
            extremelycold = base0C;
            cold = base0C;
            moderate = base0C;
            hot = base0D;
            extremelyhot = base07;
          };
          stats = base07;
          status = base07;
          temperature = base04;
          icon = base07;
        };
        calendar = {
          contextdays = base02;
          days = base04;
          currentday = base07;
          paginator = base07;
          weekdays = base07;
          yearmonth = base07;
        };
        time = {
          timeperiod = base07;
          time = base07;
        };
        text = base04;
        border.color = base02;
        background.color = base00;
        card.color = base01;
      };
      battery = {
        slider = {
          puck = base03;
          backgroundhover = base02;
          background = base02;
          primary = base0D;
        };
        icons = {
          active = base0D;
          passive = base0F;
        };
        listitems = {
          active = base0D;
          passive = base04;
        };
        text = base04;
        label.color = base0D;
        border.color = base02;
        background.color = base00;
        card.color = base01;
      };
      systray.dropdownmenu = {
        divider = base01;
        text = base04;
        background = base00;
      };
      bluetooth = {
        iconbutton = {
          active = base0C;
          passive = base04;
        };
        icons = {
          active = base0C;
          passive = base0F;
        };
        listitems = {
          active = base0C;
          passive = base04;
        };
        switch = {
          puck = base02;
          disabled = base02;
          enabled = base0C;
          divider = base02;
        };
        status = base03;
        text = base04;
        label.color = base0C;
        border.color = base02;
        background.color = base00;
        card.color = base01;
      };
      network = {
        iconbuttons = {
          active = base0C;
          passive = base04;
        };
        icons = {
          active = base0C;
          passive = base0F;
        };
        listitems = {
          active = base0C;
          passive = base04;
        };
        status.color = base03;
        text = base04;
        label.color = base0C;
        border.color = base02;
        background.color = base00;
        card.color = base01;
      };
      volume = {
        input_slider = {
          puck = base02;
          backgroundhover = base02;
          background = base02;
          primary = base0D;
        };
        audio_slider = {
          puck = base02;
          backgroundhover = base02;
          background = base02;
          primary = base0D;
        };
        icons = {
          active = base0D;
          passive = base0F;
        };
        iconbutton = {
          active = base0D;
          passive = base04;
        };
        listitems = {
          active = base0D;
          passive = base04;
        };
        border.color = base02;
        background.color = base00;
      };
      media = {
        slider = {
          puck = base03;
          backgroundhover = base02;
          background = base02;
          primary = base07;
        };
        buttons = {
          text = base00;
          background = base0C;
          enabled = base07;
          inactive = base02;
        };
        border.color = base02;
        background.color = base00;
        album = base07;
        artist = base07;
        song = base0C;
      };
    };
    tooltip = {
      text = base04;
      background = base00;
    };
    dropdownmenu = {
      divider = base01;
      text = base04;
      background = base00;
    };
    slider = {
      puck = base03;
      backgroundhover = base02;
      background = base02;
      primary = base0C;
    };
    progressbar = {
      background = base02;
      foreground = base0C;
    };
    iconbuttons = {
      active = base0C;
      passive = base04;
    };
    buttons = {
      text = base00;
      disabled = base02;
      active = base07;
      default = base0C;
    };
    switch = {
      puck = base02;
      disabled = base02;
      enabled = base0C;
    };
    iconst = {
      active = base0C;
      passive = base02;
    };
    listitems = {
      active = base0C;
      passive = base04;
    };
    label = base0C;
    feinttext = base02;
    dimtext = base0F;
    cards = base01;
  };
  label = base0C;
  icon = base00;
  bar_overflow_color = base07;
  bar_empty_color = base02;
  bar_color = base0C;
  icon_container = base0C;
  bar_container = base00;
  notification = {
    close_button.label = base00;
    close_button.background = base07;
    labelicon = base0C;
    text = base04;
    time = base03;
    border = base02;
    label = base0C;
    actions.text = base00;
    actions.background = base0C;
    background = base00;
  };
  border.color = base0C;
}
