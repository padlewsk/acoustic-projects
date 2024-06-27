function [value, ts] = poll_signal(tg, signal_name)
    % POLL_SIGNAL returns the current value and sampling time of the signal

    arguments
        tg (1, 1) slrealtime.Target
        signal_name (1, 1) string
    end

    app = slrealtime.Application(tg.ModelStatus.Application);
    sig = app.getSignals();
    sig = sig(strcmp({sig.SignalLabel}, signal_name));
    assert(~isempty(sig), 'Signal not found');

    value = tg.getsignal(sig.BlockPath, sig.PortIndex);
    ts = sig.SamplePeriod;
end
